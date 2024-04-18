gcp_project_id    = "cw-marius-sandbox"
gcp_target_region = "europe-west1"
apigee_org_name   = "marius-poc"

apigee_analytics_region = "europe-west1"
apigee_environments = [{
  name       = "dev"
  cidr_range = "10.250.0.0/22"
  hostnames  = ["marius.trygoo.gl"]
}]
