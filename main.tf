module "gcp_apis" {
  source         = "./modules/gcp_apis"
  gcp_project_id = var.gcp_project_id
}

module "vpc" {
  source = "./modules/vpc"

  gcp_project_id             = var.gcp_project_id
  vpc_name                   = "apigee"
  apigee_environments        = var.apigee_environments
  apigee_service_attachment  = module.apigee.apigee_service_attachment
  apigee_subnet              = "172.16.0.0/16"
  apigee_troubleshoot_subnet = "192.168.100.0/28"

  depends_on = [module.gcp_apis]
}

module "apigee" {
  source = "./modules/apigee"

  gcp_project_id          = var.gcp_project_id
  gcp_target_region       = var.gcp_target_region
  apigee_org_name         = var.apigee_org_name
  apigee_analytics_region = var.apigee_analytics_region
  apigee_environments     = var.apigee_environments
  apigee_vpc_id           = module.vpc.apigee_vpc
  apigee_billing_type     = "PAYG"

  depends_on = [module.gcp_apis]
}

module "psc_gke_connection" {
  source = "./modules/psc_gke_connection"

  gke_cluster_vpc         = "sandbox-network"
  psc_subnet_cidr_range   = "100.250.0.0/24"
  gcp_project_id          = "cw-marius-sandbox"
  apigee_vpc_self_link    = module.vpc.apigee_vpc_self_link
  apigee_subnet_self_link = module.vpc.apigge_subnet_self_link

}

module "dev_psc_connection" {
  source = "./modules/apigee_psc_endpoint"
  apigee_project_id = 
}
