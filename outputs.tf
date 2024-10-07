output "load_balancer_ips" {
  value = module.load_balancer.apigee_lb_ips
}

output "service_attachments" {
  value = module.apigee.apigee_service_attachment
}