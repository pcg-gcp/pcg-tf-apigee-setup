resource "google_apigee_organization" "apigee_org" {
  analytics_region                     = var.apigee_analytics_region
  project_id                           = var.gcp_project_id
  display_name                         = var.apigee_org_name
  runtime_type                         = "CLOUD"
  billing_type                         = var.apigee_billing_type
  runtime_database_encryption_key_name = var.apigee_cmek_runtimedb ? var.apigee_runtimedb_kms_key_id : null
  authorized_network                   = var.apigee_vpc_id
}

resource "google_apigee_instance" "apigee_instance" {

  for_each             = var.apigee_peering_ranges
  name                 = "${each.key}-instance"
  location             = var.gcp_target_region
  org_id               = google_apigee_organization.apigee_org.id
  consumer_accept_list = [var.gcp_project_id]
  ip_range             = "${each.value.cidr_range}/22,${var.support_ranges[each.key].support_range}"

}

resource "google_apigee_environment" "apigee_env" {

  for_each     = local.apigee_envs
  name         = each.key
  display_name = title(each.key)
  type         = each.value.env_type
  org_id       = google_apigee_organization.apigee_org.id
}

resource "google_apigee_instance_attachment" "apigee_org_instance" {

  for_each = local.apigee_envs

  instance_id = google_apigee_instance.apigee_instance[each.key].id
  environment = google_apigee_environment.apigee_env[each.key].name

}

resource "google_apigee_envgroup" "apigee_env_group" {

  for_each = local.apigee_envs

  name      = "${each.value.name}-envgroup"
  hostnames = each.value.hostnames
  org_id    = google_apigee_organization.apigee_org.id
}

resource "google_apigee_envgroup_attachment" "apigee_envgroup" {

  for_each = local.apigee_envs

  envgroup_id = google_apigee_envgroup.apigee_env_group[each.key].id
  environment = google_apigee_environment.apigee_env[each.key].name
}

