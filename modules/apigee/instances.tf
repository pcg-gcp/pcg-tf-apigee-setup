resource "google_apigee_instance" "apigee_instance" {

  for_each             = {for instance in var.apigee_instances: "${instance.location}-instance" => instance}
  name                 = each.value.name != null ? each.value.name : "${each.value.location}-instance"
  location             = each.value.location
  org_id               = google_apigee_organization.apigee_org.id
  consumer_accept_list = [var.gcp_project_id]
  ip_range             = each.value.cidr_range

}
