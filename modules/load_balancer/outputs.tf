output "apigee_lb_ips" {
  value = { for env in local.apigee_envs: env.name => {
    name = env.name
    hostnames = env.hostnames
    ip_address = google_compute_global_address.apigee_external_ip[env.name].address
  }}
}