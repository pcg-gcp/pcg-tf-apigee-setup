output "apigee_service_attachment" {
  value = {
    for instance in google_apigee_instance.apigee_instance : instance.name => instance.service_attachment
  }
}

output "apigee_org_id" {
  value = google_apigee_organization.apigee_org.id
}
