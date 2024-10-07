resource "google_compute_region_network_endpoint_group" "apigee_neg" {

  provider = google-beta
  for_each = var.apigee_service_attachment

  name = "${each.key}-apigee-neg"

  network               = var.apigee_network_id
  subnetwork            = var.apigge_subnet_id
  network_endpoint_type = "PRIVATE_SERVICE_CONNECT"
  psc_target_service    = each.value
  region                = var.gcp_target_region
}

resource "google_compute_global_address" "apigee_external_ip" {

  for_each = local.apigee_envs
  name     = "${each.key}-apigee-ip"
}

resource "google_compute_backend_service" "apigee_backend_service" {
  for_each = var.apigee_service_attachment

  name                  = "${each.key}-apigee-backend"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  protocol              = "HTTPS"
  backend {
    group = google_compute_region_network_endpoint_group.apigee_neg[each.key].id
  }

}

resource "google_compute_url_map" "url_map" {

  for_each = var.apigee_service_attachment

  name            = "${each.key}-apigee-urlmap"
  default_service = google_compute_backend_service.apigee_backend_service[each.key].id

}

resource "google_compute_managed_ssl_certificate" "apigee_cert" {

  for_each = local.apigee_envs
  name     = "${each.key}-apigee-cert"

  managed {
    domains = each.value.hostnames
  }
}

resource "google_compute_target_https_proxy" "apigee_https_proxy" {

  for_each = local.apigee_instance_envs

  name             = "${each.key}-apigee-proxy"
  url_map          = google_compute_url_map.url_map[each.value.instance].id
  ssl_certificates = [google_compute_managed_ssl_certificate.apigee_cert[each.value.env].id]
}

resource "google_compute_global_forwarding_rule" "apigee_fwd" {

  for_each = local.apigee_instance_envs

  name                  = "${each.key}-apigee-fwd"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "443"
  target                = google_compute_target_https_proxy.apigee_https_proxy[each.key].id
  ip_address            = google_compute_global_address.apigee_external_ip[each.value.env].id
}
