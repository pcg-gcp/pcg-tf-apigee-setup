resource "google_dns_record_set" "apigge_instance" {
  for_each = var.dns_records
  
  name = "${each.value}.${google_dns_managed_zone.apigee_zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.apigee_zone.name

  rrdatas = [""]
}