resource "google_compute_network" "apigee_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "apigee_subnetwork" {

  for_each      = local.apigee_envs
  name          = "${each.value.name}-apigee-subnet"
  region        = var.gcp_target_region
  ip_cidr_range = each.value.cidr_range
  network       = google_compute_network.apigee_network.id
}

resource "google_compute_global_address" "apigee_range" {

  for_each      = local.apigee_envs
  name          = "${each.value.name}-apigee-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 22
  network       = google_compute_network.apigee_network.id
}

resource "google_service_networking_connection" "apigee_vpc_connection" {
  network                 = google_compute_network.apigee_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = etwork                 = google_compute_network.apigee_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [ for range in google_compute_global_address.apigee_range : range.name ]
}
