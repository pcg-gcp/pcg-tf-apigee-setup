resource "google_project_service" "gcp_apis" {
  for_each = toset([
    "apigee.googleapis.com",
    "servicenetworking.googleapis.com",
    "compute.googleapis.com",
    "cloudkms.googleapis.com"
  ])
  
  project = var.gcp_project_id
  service = each.value

  timeouts {
    create = "30m"
    update = "40m"
  }
}
