gcp_project_id          = "cw-apigee-poc-328212"
gcp_target_region       = "europe-west1"
apigee_org_name         = "apigee-poc-org"

apigee_analytics_region = "europe-west1"
apigee_environments = [{
  name       = "dev"
  cidr_range = "10.0.0.0/24"
  hostnames  = ["poc.apigee.trygoo.gl"]
}]
