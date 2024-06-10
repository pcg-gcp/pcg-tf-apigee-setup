variable "dns_zone" {
  type    = string
  default = "apigee.trygoo.gl."
}

variable "apigee_dns_records" {
  type = map(object({
    hostnames  = list(string)
    ip_address = string
    name       = string
  }))
}
