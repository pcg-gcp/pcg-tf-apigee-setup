variable "gcp_target_region" {
  type    = string
  default = "europe-west3"
}


variable "apigee_environments" {
  type = list(object({
    name       = string
    cidr_range = string
    hostnames  = list(string)
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