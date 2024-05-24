resource "google_compute_address" "nat_ip" {
  count = var.cloud_nat_enabled ? 1 : 0

  name         = "apigee-nat-address-0"
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
  region       = var.gcp_target_region
}

resource "google_compute_router" "nat_router" {

  count = var.cloud_nat_enabled ? 1 : 0

  name    = "apigee-nat-router"
  region  = var.gcp_target_region
  network = google_compute_network.apigee_network.id

}

resource "google_compute_router_nat" "apigee_nat" {

  count = var.cloud_nat_enabled ? 1 : 0

  name                   = "apigee-cloud-nat"
  router                 = google_compute_router.nat_router[0].name
  region                 = google_compute_router.nat_router[0].region
  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips = [
    google_compute_address.nat_ip[0].self_link
  ]

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = false
    filter = "ERRORS_ONLY"
  }
}
