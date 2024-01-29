resource "google_project_service" "gcp_apis" {
  for_each = toset([
    "apigee.googleapis.com",
    "servicenetworking.googleapis.com",
    "compute.googleapis.com",
    "cloudkms.googleapis.com",
    "dns.googleapis.com"
  ])
  
  project = var.gcp_project_id
  service = each.value
  disable_on_destroy = false

  timeouts {
    create = "30m"
    update = "40m"
  }
}
