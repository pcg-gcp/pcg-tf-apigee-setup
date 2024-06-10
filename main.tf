module "gcp_apis" {
  source         = "./modules/gcp_apis"
  gcp_project_id = var.gcp_project_id
}

module "vpc" {
  source = "./modules/vpc"

  gcp_project_id          = var.gcp_project_id
  gcp_target_region       = var.gcp_target_region
  vpc_name                = "apigee"
  apigee_environments     = var.apigee_environments
  apigee_management_range = "192.168.250.0"
  apigee_peering_range    = "172.16.0.0"

  depends_on = [module.gcp_apis]
}

module "apigee" {
  source = "./modules/apigee"

  gcp_project_id          = var.gcp_project_id
  gcp_target_region       = var.gcp_target_region
  apigee_org_name         = var.apigee_org_name
  apigee_instances        = var.apigee_instances
  apigee_analytics_region = var.apigee_analytics_region
  apigee_environments     = var.apigee_environments
  apigee_vpc_id           = module.vpc.apigee_vpc
  apigee_billing_type     = "SUBSCRIPTION"

  depends_on = [module.gcp_apis]
}

module "load_balancer" {

  source = "./modules/load_balancer"

  apigee_service_attachment = module.apigee.apigee_service_attachment
  apigee_network_id         = module.vpc.apigee_vpc
  apigge_subnet_id          = module.vpc.apigee_subnet
  apigee_environments       = var.apigee_environments

}

module "dns" {
  source = "./modules/dns"
  apigee_dns_records = module.load_balancer.apigee_lb_ips

}

module "psc_endpoint_apigee" {

  source = "./modules/apigee_psc_endpoint"

  apigee_project_id             = var.gcp_project_id
  apigee_org_id                 = module.apigee.apigee_org_id
  apigee_instance_region        = var.gcp_target_region
  apigee_endpoint_attachment_id = "gke-cluster-test"
  apigee_network_id             = module.vpc.apigee_vpc
  dns_name                      = "marius.de."
  dns_records                   = ["*"]
  psc_attachment_network        = "sandbox-network"
  psc_subnet_cidr_range         = "10.250.0.0/28"
  psc_attachment_target         = "europe-west1/backendServices/a1a2e4149c4f14a59823f0fcc387d15f"
  psc_attachment_project        = "cw-marius-sandbox"
  psc_attachment_target_region  = "europe-west1"
}
