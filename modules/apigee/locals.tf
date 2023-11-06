locals {
  apigee_envs = { for env in var.apigee_environments : env.name => env }

}
