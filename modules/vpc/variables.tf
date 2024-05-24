variable "gcp_project_id" {
  type = string
}

variable "gcp_target_region" {
  type    = string
  default = "europe-west1"
}

variable "cloud_nat_enabled" {
  type        = bool
  default     = true
  description = "Determines if a Cloud NAT for external internet access is deployed in the Apigee VPC"
}

variable "vpc_name" {
  type = string
}

variable "apigee_subnet" {
  type    = string
  default = "172.16.0.0/16"
}

variable "apigee_peering_range" {
  type = string
}

variable "apigee_management_range" {
  type = string
}

variable "apigee_environments" {
  type = list(object({
    name       = string
    cidr_range = string
    hostnames  = list(string)
  }))
}
