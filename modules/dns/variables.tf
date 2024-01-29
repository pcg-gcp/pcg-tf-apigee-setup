variable "dns_zone" {
  type = string
  default = "apigee.trygoo.gl."
}

variable "dns_records" {
  type = set(string)
}