resource "google_apigee_environment" "apigee_env" {

  for_each       = local.apigee_envs
  name           = each.key
  display_name   = title(each.key)
  description    = each.value.description
  api_proxy_type = each.value.api_proxy_type
  type           = var.apigee_billing_type == "PAYG" ? each.value.env_type : null
  org_id         = google_apigee_organization.apigee_org.id
}

resource "google_apigee_instance_attachment" "apigee_org_instance" {

  for_each = local.apigee_attach_envs_to_instances

  instance_id = google_apigee_instance.apigee_instance[each.value.instance].id
  environment = google_apigee_environment.apigee_env[each.value.environment].name

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

resource "google_apigee_environment_keyvaluemaps" "kvm" {
  for_each = local.apigee_env_key_value_maps

  env_id = google_apigee_environment.apigee_env[each.value.env].id
  name = each.value.kvm

}

resource "google_apigee_env_keystore" "apigee_keystore" {
  for_each = local.apigee_env_keystores
  env_id   = google_apigee_environment.apigee_env[each.value.env].id
  name     = each.value.keystore_name
}
