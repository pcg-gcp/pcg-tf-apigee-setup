locals {
  env_hosts = merge([ for env in var.apigee_dns_records : { for host in env.hostnames: "${env.name}-${replace(host, ".", "-")}" => {
    env = env.name
    hostname = host
    ip_address = env.ip_address
  } }]...)
}

resource "google_dns_record_set" "apigge_instance" {
  for_each = local.env_hosts
  
  name = "${split(".", each.value.hostname)[0]}.${google_dns_managed_zone.apigee_zone.dns_name}"
  type = "A"
  ttl  = 120

  managed_zone = google_dns_managed_zone.apigee_zone.name

  rrdatas = [each.value.ip_address]
}