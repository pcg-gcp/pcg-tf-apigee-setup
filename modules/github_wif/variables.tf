variable "gcp_project_id" {
  type        = string
  description = "The ID of the Google Cloud Platform (GCP) project where Apigee resources will be deployed."
}

variable "sa_mapping" {
  type = map(object({
    sa_name   = string
    attribute = string
  }))
  description = "Service Account resource names and corresponding WIF provider attributes. If attribute is set to `*` all identities in the pool are granted access to SAs."
  default     = {}
}