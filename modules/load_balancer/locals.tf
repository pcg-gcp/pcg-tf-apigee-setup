locals {
  apigee_envs = { for env in var.apigee_environments : env.name => env }

  apigee_instance_envs = merge([for env in var.apigee_environments : { for att_instance in env.attached_instances : "${env.name}-${att_instance}" => {
    env      = env.name
    instance = att_instance
  } }]...)
}
