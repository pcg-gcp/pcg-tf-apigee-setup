variable "apigee_org_id" {
  type    = string
  default = "Organization Id of the Apigee that should be connected"
}

variable "apigee_project_id" {
  type        = string
  description = "GCP project id of where the Apigee organization is located"
}

variable "apigee_endpoint_attachment_id" {
  type = string
}

variable "apigee_instance_region" {
  type = string
}

variable "apigee_network_id" {
  type = string
  description = "ID of the VPC with which the Apigee organization is peered"
}

variable "psc_attachment_network" {
  type        = string
  description = "Id of the VPC where the target services is located"
}

variable "psc_attachment_project" {
  type        = string
  description = "GCP project Id where the service of the PSC attachment is located"
}

variable "psc_subnet_name" {
  type = string
  default = "psc-subnet"
}

variable "psc_subnet_cidr_range" {
  type        = string
  description = "CIDR range for the PSC subnet in the attachment project"
}

variable "psc_attachment_target_region" {
  type        = string
  description = "Region in which the PSC attachment get created"
}

variable "psc_attachment_target" {
  type        = string
  description = "Forwarding rule of the LB that should be reachable over PSC. Value is retrieveable via the following command `gcloud compute forwarding-rules list`"
}

variable "dns_name" {
  type = string
  description = "Name of the internal DNS zone under which the services behind PSC should be reachable"
}

variable "dns_records" {
  type = list(string)
  default = ["*"]
  description = "The DNS record under which Apigee can reach the ingress behind PSC"
}
