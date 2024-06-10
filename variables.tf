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
  }))
}

variable "apigee_instances" {
  type = list(object({
    name       = optional(string, null)
    location   = string
    cidr_range = string
  }))
}

variable "apigee_cmek_runtimedb" {
  type    = bool
  default = false
}