resource "google_dns_managed_zone" "apigee_zone" {
  name        = "apigee-poc"
  dns_name    = var.dns_zone
  visibility = "public"
  
}