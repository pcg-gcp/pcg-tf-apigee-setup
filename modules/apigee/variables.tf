variable "gcp_project_id" {
  type = string
}

variable "gcp_target_region" {
  type    = string
  default = "europe-west3"
}

variable "apigee_analytics_region" {
  type    = string
  default = "europe-west3"
}

variable "apigee_org_name" {
  type = string
}

variable "apigee_environments" {
  type = list(object({
    name       = string
    cidr_range = string
    hostnames = list(string)
    env_type = optional(string, "COMPREHENSIVE")
  }))
}

variable "apigee_billing_type" {
  type    = string
  default = "PAYG"
}

variable "apigee_cmek_runtimedb" {
  type = bool
  default = false
}

variable "apigee_runtimedb_kms_key_id" {
  type = string
  default = ""
}

variable "apigee_vpc_id" {
  type = string
}

variable "apigee_peering_ranges" {
  type = map(object({
    name = string
    cidr_range = string
  }))
}