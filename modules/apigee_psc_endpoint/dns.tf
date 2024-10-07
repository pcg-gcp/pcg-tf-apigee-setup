locals {
  dns_records = { for record in var.dns_records : record => record }
}

resource "google_dns_managed_zone" "internal_zone" {
  name        = "${replace(trimsuffix(var.dns_name, "."), ".", "-")}-int-zone"
  dns_name    = var.dns_name
  description = "Internal DNS zone to access Ingress behind private service connect"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = var.apigee_network_id
    }
  }
}

resource "google_dns_record_set" "psc_dns_record" {
  for_each     = local.dns_records
  name         = "${each.value}.${google_dns_managed_zone.internal_zone.dns_name}"
  type         = "A"
  ttl          = 60
  managed_zone = google_dns_managed_zone.internal_zone.name
  rrdatas      = [google_apigee_endpoint_attachment.apigee_endpoint_attachment.host]
}

# https://cloud.google.com/vpc/docs/configure-private-services-access#gcloud_6
# necessary that Apigee can access the private DNS zones
resource "google_service_networking_peered_dns_domain" "apigee_peered_internal_zone" {

  provider = google-beta
  
  name       = "apigee-${replace(trimsuffix(var.dns_name, "."), ".", "-")}-int-zone"
  network    = "apigee" #var.apigee_network_id
  dns_suffix = var.dns_name
  service    = "servicenetworking.googleapis.com"
}
