variable "kvm_entry_name" {
  type = string
}

variable "kvm_entry_value" {
  type = string
  sensitive = true
}

variable "apigee_env_id" {
  type = string
}

variable "apigee_kvm_name" {
  type = string
}