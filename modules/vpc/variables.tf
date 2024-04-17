variable "gcp_project_id" {
  type = string
}

variable "gcp_target_region" {
  type    = string
  default = "europe-west1"
}

variable "vpc_name" {
  type = string
}

variable "apigee_subnet" {
  type = string
  default = "172.16.0.0/16"
}

variable "apigee_troubleshoot_subnet" {
  type = string
  default = "192.168.100.0/28"
}

variable "apigee_environments" {
  type = list(object({
    name = string
    cidr_range = string
    hostnames = list(string)
  }))
}

variable "apigee_service_attachment" {
  type = map(string)
}