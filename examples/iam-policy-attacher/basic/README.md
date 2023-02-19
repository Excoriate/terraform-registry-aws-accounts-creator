<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.55.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../modules/iam-policy-attacher | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | n/a | yes |
| <a name="input_config"></a> [config](#input\_config) | The configuration for the IAM policy attacher. The current configuration allowed are:<br>  - name - The name of the IAM policy attacher<br>  - users - The list of IAM users to attach the policy to<br>  - role - The IAM role to attach the policy to<br>  - groups - The list of IAM groups to attach the policy to<br>  - policy\_arn - The ARN of the IAM policy to attach | <pre>list(object({<br>    name       = string<br>    users      = optional(list(string))<br>    role       = string<br>    groups     = optional(list(string))<br>    policy_arn = string<br>  }))</pre> | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Enable or disable the module | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_iam_policy_attachment_id"></a> [iam\_policy\_attachment\_id](#output\_iam\_policy\_attachment\_id) | The ID of the IAM policy attachment. |
| <a name="output_iam_policy_attachment_name"></a> [iam\_policy\_attachment\_name](#output\_iam\_policy\_attachment\_name) | The name of the IAM policy attachment. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
