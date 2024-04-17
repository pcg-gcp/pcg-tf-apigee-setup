resource "google_project_service" "gcp_apis" {
  for_each = toset([
    "compute.googleapis.com"
  ])
  
  project = var.backend_gcp_project_id
  service = each.value
  disable_on_destroy = false

  timeouts {
    create = "30m"
    update = "40m"
  }
}


resource "google_compute_network" "backend_vpc" {
  name                    = var.backend_vpc_name
  description             = "VPC for Backend services"
  project                 = var.backend_gcp_project_id
  auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "gke_subnetwork" {
  name          = "backend-gke-subnet"
  description   = "Subnetwork for gke cluster"
  project       = var.backend_gcp_project_id
  depends_on    = [google_compute_network.backend_vpc]
  region        = var.backend_gcp_region
  ip_cidr_range = var.gke_cidr_range
  network       = google_compute_network.backend_vpc.name
}

resource "google_compute_subnetwork" "proxy_only_subnet" {
  name          = "proxy-subnet"
  description   = "Proxy only subnet set up for ingress load balancer"
  project       = var.backend_gcp_project_id
  depends_on    = [google_compute_network.backend_vpc]
  region        = var.backend_gcp_region
  ip_cidr_range = var.proxy_cidr_range
  network       = google_compute_network.backend_vpc.id
}
/*
resource "google_compute_subnetwork" "private_service_connector_subnet" {
  name          = "psc-subnet"
  description   = "Subnet for Private service connect"
  depends_on = [google_compute_network.backend_vpc ]
  region        = var.backend_gcp_region
  ip_cidr_range = var.psc_cidr_range
  network       = google_compute_network.backend_vpc.id
}

*/
