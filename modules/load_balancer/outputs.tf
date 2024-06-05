output "apigee_lb_ips" {
  value = { for ip in google_compute_global_address.apigee_external_ip: ip.name => ip.address}
}