variable "gcp_project_id" {
  type = string
}

variable "gcp_target_region" {
  type    = string
  default = "europe-west3"
}

variable "apigee_analytics_region" {
  type    = string
  default = "europe-west1"
}

variable "apigee_org_name" {
  type = string
}

variable "apigee_environments" {
  type = list(object({
    name = string
    cidr_range = string
    hostnames = list(string)
    env_type = optional(string, "COMPREHENSIVE")
  }))
}

variable "apigee_cmek_runtimedb" {
  type = bool
  default = false
}

variable "support_ranges" {
  type = map(object({
    support_range = string
  }))
}