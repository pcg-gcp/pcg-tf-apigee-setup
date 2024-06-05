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

  dns_records = ["dev", "prod"]

}
/* module "psc_endpoint_apigee" {

  providers = {
    google-beta.fels-platform = google-beta.fels-platform
  }
  source = "./modules/apigee_psc_endpoint"

  apigee_project_id             = var.gcp_project_id
  apigee_org_id                 = module.apigee.apigee_org_id
  apigee_instance_region        = var.gcp_target_region
  apigee_endpoint_attachment_id = "gke-cluster-test"
  apigee_network_id             = module.vpc.apigee_vpc
  dns_name                      = "fels-test.local."
  dns_records                   = ["*"]
  psc_attachment_network        = "vpc-network-93a6487a02"
  psc_subnet_cidr_range         = "10.250.0.0/28"
  psc_attachment_target         = "europe-west3/backendServices/a9116abd4a6cf4dd9adccd852a96b617"
  psc_attachment_project        = "fels-test"
  psc_attachment_target_region  = "europe-west3"
} */
