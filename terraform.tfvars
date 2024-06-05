gcp_project_id    = "cw-apigee-poc-328212"
gcp_target_region = "europe-west1"
apigee_org_name   = "pcg-apigee-poc"

apigee_analytics_region = "europe-west1"
apigee_environments = [{
  name       = "dev"
  cidr_range = "172.16.0.0/22"
  hostnames  = ["dev.apigee.trygoo.gl"]
  #env_type = "COMPREHENSIVE"
},
/* {
  name       = "prod"
  cidr_range = "172.16.8.0/22"
  hostnames  = ["prod.apigee.trygoo.gl"]
  #env_type = "COMPREHENSIVE"
} */
]
