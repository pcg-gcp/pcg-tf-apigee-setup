resource "google_compute_subnetwork" "psc_subnet" {

  name          = var.psc_subnet_name
  network       = var.psc_attachment_network
  ip_cidr_range = var.psc_subnet_cidr_range
  project       = var.psc_attachment_project
  purpose       = "PRIVATE_SERVICE_CONNECT"
  role          = "ACTIVE"

}

resource "google_compute_service_attachment" "psc_service_attachment" {

  name                  = "apigee-psc-attachment"
  region                = var.psc_attachment_target_region
  connection_preference = "ACCEPT_AUTOMATIC"
  /* consumer_accept_lists {
    project_id_or_num = var.apigee_project_id
    connection_limit = 10
  } */
  enable_proxy_protocol = true
  nat_subnets = [google_compute_subnetwork.psc_subnet.id]

  target_service = var.psc_attachment_target 
  project = var.psc_attachment_project

  lifecycle {
    ignore_changes = [target_service]
  }
}

resource "google_compute_firewall" "allow_psc_traffic" {

  name          = "apigee-allow-psc-traffic"
  network       = var.psc_attachment_network
  source_ranges = [var.psc_subnet_cidr_range]
  direction     = "INGRESS"
  allow {
    ports    = [80]
    protocol = "TCP"
  }

  project = var.psc_attachment_project
}