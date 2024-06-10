locals {
  apigee_envs = { for env in var.apigee_environments : env.name => env }

  apigee_attach_envs_to_instances = merge(flatten([for env in local.apigee_envs : { for instance in env.attached_instances : "${env.name}-${instance}" => { environment = env.name, instance = instance } }])...)
  
}
