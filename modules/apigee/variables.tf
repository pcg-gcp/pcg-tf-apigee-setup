variable "gcp_project_id" {
  type = string
}

variable "gcp_target_region" {
  type    = string
  default = "europe-west1"
}

variable "apigee_analytics_region" {
  type    = string
  default = "europe-west1"
}

variable "apigee_org_name" {
  type = string
}

variable "apigee_org_retention" {
  type    = string
  default = "MINIMUM"
}

variable "apigee_environments" {
  type = list(object({
    name               = string
    description        = optional(string)
    hostnames          = list(string)
    api_proxy_type     = optional(string)
    env_type           = optional(string, "COMPREHENSIVE")
    attached_instances = list(string)
    key_value_maps     = optional(list(string))
    keystores          = optional(list(string))
  }))
}

variable "apigee_instances" {
  type = list(object({
    name       = optional(string)
    location   = string
    cidr_range = string
  }))
}

variable "apigee_billing_type" {
  type    = string
  default = "SUBSCRIPTION"
}

variable "apigee_cmek_runtimedb" {
  type    = bool
  default = false
}

variable "apigee_runtimedb_kms_key_id" {
  type    = string
  default = ""
}

variable "apigee_vpc_id" {
  type = string
}
