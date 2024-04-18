resource "google_project_service" "gcp_apis" {
  for_each = toset([
    "compute.googleapis.com",
    "container.googleapis.com"
  ])

  project            = var.producer_gcp_project_id
  service            = each.value
  disable_on_destroy = false

  timeouts {
    create = "30m"
    update = "40m"
  }
}


resource "google_compute_network" "producer_vpc" {
  name                    = var.producer_vpc_name
  description             = "VPC for producer services"
  project                 = var.producer_gcp_project_id
  auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "gke_subnetwork" {
  name          = "producer-gke-subnet"
  description   = "Subnetwork for gke cluster"
 
  depends_on    = [google_compute_network.producer_vpc]
  region        = var.producer_gcp_region
  ip_cidr_range = var.gke_cidr_range
  network       = google_compute_network.producer_vpc.name
 // private_ip_google_access = true // to pull container images
}

resource "google_compute_subnetwork" "proxy_only_subnet" {
  name          = "proxy-subnet"
  description   = "Proxy only subnet set up for ingress load balancer"
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
  
  depends_on    = [google_compute_network.producer_vpc]
  region        = var.producer_gcp_region
  ip_cidr_range = var.proxy_cidr_range
  network       = google_compute_network.producer_vpc.id
}

resource "google_compute_subnetwork" "private_service_connector_subnet" {
  name          = "psc-subnet"
  purpose       = "PRIVATE_SERVICE_CONNECT"
  description   = "Subnet for Private service connect"
  depends_on    = [google_compute_network.producer_vpc]
  region        = var.producer_gcp_region
  ip_cidr_range = var.psc_cidr_range
  network       = google_compute_network.producer_vpc.id
}

