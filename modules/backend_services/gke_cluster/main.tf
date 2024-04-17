resource "google_container_cluster" "backend_cluster" {
  name               = ""
  location           = var.backend_gcp_region
  initial_node_count = 3
  deletion_protection = false
}