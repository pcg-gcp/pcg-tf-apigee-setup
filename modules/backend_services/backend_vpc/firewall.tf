resource "google_compute_firewall" "allow_proxy_ingress" {
  name    = "allow-proxy-ingress"
  project = var.backend_gcp_project_id
  network = google_compute_network.backend_vpc.name
  
  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    =  var.container_ports
  }
  source_ranges = split(",", var.proxy_cidr_range)
}

