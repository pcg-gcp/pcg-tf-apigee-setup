module "gcp_apis" {
  source         = "./modules/gcp_apis"
  gcp_project_id = var.gcp_project_id
}

module "vpc" {
  source = "./modules/vpc"

  gcp_project_id            = var.gcp_project_id
  vpc_name                  = "apigee"
  apigee_environments       = var.apigee_environments
  apigee_service_attachment = module.apigee.apigee_service_attachment

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
  apigee_peering_ranges   = module.vpc.apigee_peering_ranges
  support_ranges          = var.support_ranges

  depends_on = [module.gcp_apis]
}

module "producer_service" {

  source = "./modules/producer_services"
  providers = {
    google = google.producer_service
  }
  producer_gcp_project_id = var.producer_gcp_project_id //project in which producer projects run
  producer_gcp_region     = var.producer_gcp_region
  gke_cidr_range         = "10.0.0.0/22"
  container_ports        = [9376, 8080]

}
