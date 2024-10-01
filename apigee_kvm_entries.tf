module "dev_random_int_api_key" {
  source = "./modules/apigee_kvm_entry"

  apigee_kvm_name = "credentials"
  apigee_env_id = module.apigee.apigee_env_ids["dev"]
  kvm_entry_name = "random-int-api-key"
  kvm_entry_value = "this-is-a-test-api-key"

}