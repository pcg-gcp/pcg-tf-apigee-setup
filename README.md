## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 6.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 6.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apigee"></a> [apigee](#module\_apigee) | ./modules/apigee | n/a |
| <a name="module_apigee_target_server"></a> [apigee\_target\_server](#module\_apigee\_target\_server) | ./modules/apigee_target_server | n/a |
| <a name="module_dev_random_int_api_key"></a> [dev\_random\_int\_api\_key](#module\_dev\_random\_int\_api\_key) | ./modules/apigee_kvm_entry | n/a |
| <a name="module_dns"></a> [dns](#module\_dns) | ./modules/dns | n/a |
| <a name="module_gcp_apis"></a> [gcp\_apis](#module\_gcp\_apis) | ./modules/gcp_apis | n/a |
| <a name="module_load_balancer"></a> [load\_balancer](#module\_load\_balancer) | ./modules/load_balancer | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apigee_analytics_region"></a> [apigee\_analytics\_region](#input\_apigee\_analytics\_region) | The specific GCP region where Apigee analytics data will be stored and processed. Not all GCP regions are available as analytics region | `string` | `"europe-west1"` | no |
| <a name="input_apigee_cmek_runtimedb"></a> [apigee\_cmek\_runtimedb](#input\_apigee\_cmek\_runtimedb) | This variable determines whether to enable Customer-Managed Encryption Keys (CMEK) for your Apigee Runtime Database. When set to 'true', Apigee will encrypt the runtime database using keys managed by you in Google Cloud Key Management Service (KMS). The default value is 'false'. | `bool` | `false` | no |
| <a name="input_apigee_environments"></a> [apigee\_environments](#input\_apigee\_environments) | This variable defines a list of Apigee environments to be provisioned within your Apigee organization. Each environment represents a separate deployment stage for your APIs, such as 'dev', 'test', or 'prod'. You can customize the configurations for each environment including hostnames, API proxy types, environment types, attached instances, key-value maps, and keystores. | <pre>list(object({<br/>    name               = string<br/>    description        = optional(string)<br/>    hostnames          = list(string)<br/>    api_proxy_type     = optional(string)<br/>    env_type           = optional(string, "COMPREHENSIVE")<br/>    attached_instances = list(string)<br/>    key_value_maps     = optional(list(string), [])<br/>    keystores          = optional(list(string), [])<br/>  }))</pre> | n/a | yes |
| <a name="input_apigee_instances"></a> [apigee\_instances](#input\_apigee\_instances) | This variable specifies a list of Apigee instances to deploy within your Apigee organization. Each instance represents a dedicated runtime environment for your APIs. You can define the name, location, and CIDR range for each instance. The name is an optional field and can be auto-generated if not provided. | <pre>list(object({<br/>    name       = optional(string, null)<br/>    location   = string<br/>    cidr_range = string<br/>  }))</pre> | n/a | yes |
| <a name="input_apigee_org_name"></a> [apigee\_org\_name](#input\_apigee\_org\_name) | The desired name for your Apigee organization. This name must be unique within your GCP project. | `string` | n/a | yes |
| <a name="input_apigee_org_retention"></a> [apigee\_org\_retention](#input\_apigee\_org\_retention) | n/a | `string` | `"MINIMUM"` | no |
| <a name="input_apigee_target_servers"></a> [apigee\_target\_servers](#input\_apigee\_target\_servers) | This variable defines a list of target servers that your Apigee proxies can communicate with. Each target server represents a backend service that handles API requests. You can specify the name, description, protocol, host, port, and the Apigee environment name associated with each target server. | <pre>list(object({<br/>    name            = string<br/>    description     = optional(string)<br/>    protocol        = optional(string, "HTTP")<br/>    host            = string<br/>    port            = optional(number)<br/>    apigee_env_name = string<br/>  }))</pre> | n/a | yes |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | The ID of the Google Cloud Platform (GCP) project where Apigee resources will be deployed. | `string` | n/a | yes |
| <a name="input_gcp_target_region"></a> [gcp\_target\_region](#input\_gcp\_target\_region) | The GCP region where the majority of Apigee resources, including instances, will be deployed. | `string` | `"europe-west1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_load_balancer_ips"></a> [load\_balancer\_ips](#output\_load\_balancer\_ips) | n/a |
| <a name="output_service_attachments"></a> [service\_attachments](#output\_service\_attachments) | n/a |
