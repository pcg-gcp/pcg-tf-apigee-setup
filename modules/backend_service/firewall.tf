resource "google_compute_firewall" "allow_proxy_ingress" {
  name    = "allow-proxy-ingress"
  #project = var.backend_gcp_project_id
  network = google_compute_network.backend_vpc.name
  
  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    =  var.container_ports
  }
  source_ranges = split(",", var.proxy_cidr_range)
}
/*
resource "google_compute_firewall" "allow_private_google_access" {
  name    = "allow-private-google-access"
  
  network = google_compute_network.backend_vpc.name
  
  direction = "EGRESS"
  allow {
    protocol = "tcp"
    ports    = [80]
  }
  source_ranges = ["199.36.153.8/30", "34.126.0.0/18"]
}
*/

/*
resource "google_compute_firewall" "allow-psc-nat-80" {
  name    = "allow-psc-nat-80"
  project = var.backend_gcp_project_id
  network = google_compute_network.backend_vpc.name
  
  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    =  80 
     }
  source_ranges = split(",", var.psc_cidr_range)
}
*/