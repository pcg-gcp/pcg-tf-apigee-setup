resource "google_compute_network" "apigee_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "apigee_subnet" {
  name          = "apigee-subnet"
  network       = google_compute_network.apigee_network.id
  ip_cidr_range = var.apigee_subnet
  region        = var.gcp_target_region
}

resource "google_compute_global_address" "apigee_ip_range" {

  name          = "apigee-peering-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  address       = var.apigee_peering_range #"10.250.0.0"
  prefix_length = 16
  network       = google_compute_network.apigee_network.id
}

resource "google_compute_global_address" "apigee_managed_range" {

  name          = "apigee-managed-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  address       = var.apigee_management_range #"192.168.250.0"
  prefix_length = 28
  network       = google_compute_network.apigee_network.id
}

resource "google_service_networking_connection" "apigee_vpc_connection" {
  network                 = google_compute_network.apigee_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.apigee_ip_range.name, google_compute_global_address.apigee_managed_range.name]
}
