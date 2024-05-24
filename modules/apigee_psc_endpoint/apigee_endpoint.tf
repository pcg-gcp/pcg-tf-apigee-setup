resource "google_apigee_endpoint_attachment" "apigee_endpoint_attachment" {
  org_id                 = var.apigee_org_id
  endpoint_attachment_id = var.apigee_endpoint_attachment_id
  location               = var.apigee_instance_region
  service_attachment     = google_compute_service_attachment.psc_service_attachment.self_link
}
