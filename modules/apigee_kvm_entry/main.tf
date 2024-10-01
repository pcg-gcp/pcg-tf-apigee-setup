resource "google_apigee_environment_keyvaluemaps_entries" "kvm_entry" {
  name               = var.kvm_entry_name
  value              = var.kvm_entry_value
  env_keyvaluemap_id = "${var.apigee_env_id}/keyvaluemaps/${var.apigee_kvm_name}"
}
