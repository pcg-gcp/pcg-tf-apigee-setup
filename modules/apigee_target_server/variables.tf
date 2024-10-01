variable "apigee_target_servers" {
  type = list(object({
    name          = string
    description   = optional(string)
    protocol      = optional(string, "HTTP")
    host          = string
    port          = number
    apigee_env_name = string
  }))
}

variable "apigee_env_map" {
  type = map(string)
  description = "Map of the deployed Apigee environments, mapping the env name to its ID"
}