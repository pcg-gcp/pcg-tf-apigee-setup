gcp_project_id    = "cw-marius-sandbox"
gcp_target_region = "europe-west3"
apigee_org_name   = "apigee-demo-org"
apigee_analytics_region = "europe-west1"
apigee_environments = [{
  name       = "dev"
  cidr_range = "10.0.0.0/24"
  peering_range = "192.168.0.0"
  hostnames = [ "marius.apigee.trygoo.gl" ]
}]
