output "apigee_vpc" {
  value = google_compute_network.apigee_network.id
}

output "apigee_subnet" {
  value = google_compute_subnetwork.apigee_subnet.id
}

output "apigee_peering_range" {
  value = google_compute_global_address.apigee_ip_range
}

output "apigee_vpc_self_link" {
  value = google_compute_network.apigee_network.self_link
}
output "apigge_subnet_self_link" {
  value = google_compute_subnetwork.apigee_subnet.self_link
}
