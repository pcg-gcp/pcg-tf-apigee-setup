data "google_client_config" "producer_cluster" {
  depends_on = [ google_container_cluster.producer_cluster ]

}
output "access_token" {
  value = data.google_client_config.producer_cluster.access_token  
}


# Defer reading the cluster data until the GKE cluster exists.
data "google_container_cluster" "producer_cluster" {
  depends_on = [ google_container_cluster.producer_cluster ]
  name       = "producer-service-cluster"
  location = "europe-west3-c"
}
output "cluster_certificate" {
  value = data.google_container_cluster.producer_cluster.master_auth[0].cluster_ca_certificate
  
}

output "endpoint" {
  value = data.google_container_cluster.producer_cluster.endpoint
  
}