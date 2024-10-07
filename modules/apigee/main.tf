resource "google_apigee_organization" "apigee_org" {
  analytics_region                     = var.apigee_analytics_region
  project_id                           = var.gcp_project_id
  display_name                         = var.apigee_org_name
  runtime_type                         = "CLOUD"
  retention                            = var.apigee_org_retention
  billing_type                         = var.apigee_billing_type
  runtime_database_encryption_key_name = var.apigee_cmek_runtimedb ? var.apigee_runtimedb_kms_key_id : null
  authorized_network                   = var.apigee_vpc_id

  lifecycle {
    prevent_destroy = true
  }
}

