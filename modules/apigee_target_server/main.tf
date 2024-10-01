resource "google_apigee_target_server" "target_server" {
  for_each = {for target in var.apigee_target_servers : "${target.apigee_env_name}-${target.name}" => target}

  name = each.value.name
  host = each.value.host
  port = each.value.port != null ? each.value.port : (each.value.protocol == "HTTPS" ? 443 : 80)
  env_id = var.apigee_env_map[each.value.apigee_env_name]
}