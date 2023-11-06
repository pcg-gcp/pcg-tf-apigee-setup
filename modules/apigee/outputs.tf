output "apigee_service_attachment" {
  value = {
    for instance in google_apigee_instance.apigee_instance : split("-", instance.name)[0] => instance.service_attachment
  }
}
