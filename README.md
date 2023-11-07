# Terraform Apigee Setup

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.4.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 5.4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apigee"></a> [apigee](#module\_apigee) | ./modules/apigee | n/a |
| <a name="module_gcp_apis"></a> [gcp\_apis](#module\_gcp\_apis) | ./modules/gcp_apis | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apigee_analytics_region"></a> [apigee\_analytics\_region](#input\_apigee\_analytics\_region) | n/a | `string` | `"europe-west1"` | no |
| <a name="input_apigee_cmek_runtimedb"></a> [apigee\_cmek\_runtimedb](#input\_apigee\_cmek\_runtimedb) | n/a | `bool` | `false` | no |
| <a name="input_apigee_environments"></a> [apigee\_environments](#input\_apigee\_environments) | n/a | <pre>list(object({<br>    name = string<br>    cidr_range = string<br>    hostnames = list(string)<br>    env_type = optional(string, "COMPREHENSIVE")<br>  }))</pre> | n/a | yes |
| <a name="input_apigee_org_name"></a> [apigee\_org\_name](#input\_apigee\_org\_name) | n/a | `string` | n/a | yes |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | n/a | `string` | n/a | yes |
| <a name="input_gcp_target_region"></a> [gcp\_target\_region](#input\_gcp\_target\_region) | n/a | `string` | `"europe-west3"` | no |
| <a name="input_support_ranges"></a> [support\_ranges](#input\_support\_ranges) | n/a | <pre>map(object({<br>    support_range = string<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
