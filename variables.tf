variable "gcp_project_id" {
  type        = string
  description = "The ID of the Google Cloud Platform (GCP) project where Apigee resources will be deployed."
}

variable "gcp_target_region" {
  type        = string
  default     = "europe-west1"
  description = "The GCP region where the majority of Apigee resources, including instances, will be deployed."

}

variable "apigee_analytics_region" {
  type        = string
  default     = "europe-west1"
  description = "The specific GCP region where Apigee analytics data will be stored and processed. Not all GCP regions are available as analytics region"
}

variable "apigee_org_name" {
  type        = string
  description = "The desired name for your Apigee organization. This name must be unique within your GCP project."
}

variable "apigee_org_retention" {
  type    = string
  default = "MINIMUM"
}

variable "apigee_environments" {
  type = list(object({
    name               = string
    description        = optional(string)
    hostnames          = list(string)
    api_proxy_type     = optional(string)
    env_type           = optional(string, "COMPREHENSIVE")
    attached_instances = list(string)
    key_value_maps     = optional(list(string), [])
    keystores          = optional(list(string), [])
  }))
  description = "This variable defines a list of Apigee environments to be provisioned within your Apigee organization. Each environment represents a separate deployment stage for your APIs, such as 'dev', 'test', or 'prod'. You can customize the configurations for each environment including hostnames, API proxy types, environment types, attached instances, key-value maps, and keystores."
}

variable "apigee_instances" {
  type = list(object({
    name       = optional(string, null)
    location   = string
    cidr_range = string
  }))
  description = "This variable specifies a list of Apigee instances to deploy within your Apigee organization. Each instance represents a dedicated runtime environment for your APIs. You can define the name, location, and CIDR range for each instance. The name is an optional field and can be auto-generated if not provided."
}

variable "apigee_cmek_runtimedb" {
  type        = bool
  default     = false
  description = "This variable determines whether to enable Customer-Managed Encryption Keys (CMEK) for your Apigee Runtime Database. When set to 'true', Apigee will encrypt the runtime database using keys managed by you in Google Cloud Key Management Service (KMS). The default value is 'false'."
}

variable "apigee_target_servers" {
  type = list(object({
    name            = string
    description     = optional(string)
    protocol        = optional(string, "HTTP")
    host            = string
    port            = optional(number)
    apigee_env_name = string
  }))
  description = "This variable defines a list of target servers that your Apigee proxies can communicate with. Each target server represents a backend service that handles API requests. You can specify the name, description, protocol, host, port, and the Apigee environment name associated with each target server."
}
