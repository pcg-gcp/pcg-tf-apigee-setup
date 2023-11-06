resource "google_project_service_identity" "apigee_service_identity" {
  provider = google-beta

  project = var.gcp_project_id
  service = "apigee.googleapis.com"
}