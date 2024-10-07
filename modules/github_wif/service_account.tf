resource "google_service_account" "apigee_cicd_service_account" {
  account_id   = "apigee-github"
  display_name = "Github Action Apigee SA"
  project      = var.gcp_project_id
}

resource "google_project_iam_member" "apigee_" {
  role    = "roles/apigee.admin"
  member  = google_service_account.apigee_cicd_service_account.member
  project = var.gcp_project_id
}
