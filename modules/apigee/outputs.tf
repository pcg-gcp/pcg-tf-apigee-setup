output "apigee_service_attachment" {
  value = {
    for instance in google_apigee_instance.apigee_instance : instance.name => instance.service_attachment
  }
}

output "apigee_org_id" {
  value = google_apigee_organization.apigee_org.id
}

output "apigee_env_ids" {
  value = { for env in var.apigee_environments : env.name => google_apigee_environment.apigee_env[env.name].id }
}