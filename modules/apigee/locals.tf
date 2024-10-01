locals {
  apigee_envs = { for env in var.apigee_environments : env.name => env }

  apigee_attach_envs_to_instances = merge(flatten([for env in local.apigee_envs : { for instance in env.attached_instances : "${env.name}-${instance}" => { environment = env.name, instance = instance } }])...)

  apigee_env_keystores = merge(flatten([for env in local.apigee_envs : {
    for keystore in env.keystores : "${env.name}-${keystore}" => {
      env           = env.name
      keystore_name = keystore
    }
  }])...)

  apigee_env_key_value_maps = merge(flatten([for env in local.apigee_envs : {
    for kvm in env.key_value_maps : "${env.name}-${kvm}" => {
      env = env.name
      kvm = kvm
    }
  }])...)

}
