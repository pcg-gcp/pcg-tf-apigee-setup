variable "gcp_target_region" {
  type    = string
  default = "europe-west1"
}


variable "apigee_environments" {
  type = list(object({
    name       = string
    hostnames  = list(string)
    attached_instances = list(string)
  }))
}

variable "apigee_service_attachment" {
  type = map(string)
}

variable "apigee_network_id" {
  type = string
}

variable "apigge_subnet_id" {
  type = string
}