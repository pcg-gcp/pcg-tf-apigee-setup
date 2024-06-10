gcp_project_id    = "cw-apigee-poc-328212"
gcp_target_region = "europe-west1"
apigee_org_name   = "pcg-apigee-poc"

apigee_analytics_region = "europe-west1"

apigee_instances = [{
  location   = "europe-west1"
  cidr_range = "172.16.0.0/22"
}]

apigee_environments = [{
  name               = "dev"
  hostnames          = ["dev.apigee.trygoo.gl"]
  env_type           = "COMPREHENSIVE"
  attached_instances = ["europe-west1-instance"]
  },
  {
    name               = "prod"
    hostnames          = ["prod.apigee.trygoo.gl"]
    attached_instances = ["europe-west1-instance"]
    #env_type = "COMPREHENSIVE"
  }
]
