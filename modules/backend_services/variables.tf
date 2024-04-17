variable "backend_gcp_project_id" {
  type = string
}


variable "backend_vpc_name" {
  type    = string
  default = "backend-vpc"
}
variable "backend_gcp_region" {
  type    = string
  default = "europe-west1"
}

variable "gke_cidr_range" {
  type = string
}

variable "proxy_cidr_range" {
  type    = string
  default = "10.129.0.0/23"
  
}

variable "psc_cidr_range" {
  type    = string
  default = ""
}


variable "container_ports"{
  type    = list(number)
}
