<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../modules/iam-system-user | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_iam_user_config"></a> [iam\_user\_config](#input\_iam\_user\_config) | This configuration will be used to create the IAM user, that's intended for system/programmatic access.<br>The following attributes are supported:<br>- name: The name of the user to create. It can't be ommited.<br>- force\_destroy: When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force\_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed.<br>- path: Path in which to create the user. If it does not already exist, it will be created. If omitted, the user will be created at the root path.<br>For more information about this specific configuration, please refer to the following link: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user | <pre>list(object({<br>    name          = string<br>    path          = optional(string, "/")<br>    force_destroy = optional(bool, false)<br>  }))</pre> | n/a | yes |
| <a name="input_iam_user_credentials_config"></a> [iam\_user\_credentials\_config](#input\_iam\_user\_credentials\_config) | This configuration works along with the iam\_user\_config to create the IAM user, that's intended for system/programmatic access. It enables<br>the user to have access keys to perform certain actions, by creating access keys for the user. The following attributes are supported:<br>- name: The name of the user to create. It can't be ommited. It's used to identify the user to which the access keys will be created.<br>- enabled: Whether to create access keys for the user. If set to false, the access keys will not be created.<br>- pgp\_key: The PGP key to encrypt the access keys. If it's not set, the access keys will not be encrypted.<br>- status: The status of the access keys. Can be either Active or Inactive. | <pre>list(object({<br>    name    = string<br>    enabled = optional(bool, true)<br>    pgp_key = optional(string, null)<br>    status  = optional(string, "Active")<br>  }))</pre> | `null` | no |
| <a name="input_iam_user_permissions_config"></a> [iam\_user\_permissions\_config](#input\_iam\_user\_permissions\_config) | This configuration works along with the iam\_user\_config to create the IAM user, that's intended for system/programmatic access.<br>Specifically, it enables the user to have certain permissions to perform certain actions, by attaching policies to the user in<br>'json' format (i.e. the policy document). The following attributes are supported:<br>- name: The name of the user to create. It can't be ommited. It's used to identify the user to which the permissions will be attached.<br>- permissions\_boundary: The ARN of the policy that is used to set the permissions boundary for the user.<br>- policy\_inline\_json: The policy document in 'json' format. It can be used to create a policy in-line. Ensure it's set<br>and the policy\_arns\_to\_attach is set to an empty list, if you want to create a policy in-line. Both types of policies can't be<br>attached to the same user.<br>For more information, please refer to how the policy document is defined in the following link: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy | <pre>list(object({<br>    name                  = string<br>    permissions_boundary  = optional(string, null)<br>    policy_inline_json    = optional(string, null)<br>    policy_arns_to_attach = optional(list(string), [])<br>  }))</pre> | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_iam_user_arn"></a> [iam\_user\_arn](#output\_iam\_user\_arn) | The ARN of the IAM user. |
| <a name="output_iam_user_id"></a> [iam\_user\_id](#output\_iam\_user\_id) | The ID of the IAM user. |
| <a name="output_iam_user_key_id"></a> [iam\_user\_key\_id](#output\_iam\_user\_key\_id) | The list of access key IDs. |
| <a name="output_iam_user_key_secret"></a> [iam\_user\_key\_secret](#output\_iam\_user\_key\_secret) | The list of access key secrets. |
| <a name="output_iam_user_key_status"></a> [iam\_user\_key\_status](#output\_iam\_user\_key\_status) | The list of access key statuses. |
| <a name="output_iam_user_name"></a> [iam\_user\_name](#output\_iam\_user\_name) | The name of the IAM user. |
| <a name="output_iam_user_path"></a> [iam\_user\_path](#output\_iam\_user\_path) | The path of the IAM user. |
| <a name="output_iam_user_permissions_boundary"></a> [iam\_user\_permissions\_boundary](#output\_iam\_user\_permissions\_boundary) | The ARN of the policy that is used to set the permissions boundary for the user. |
| <a name="output_iam_user_policy_attached_id"></a> [iam\_user\_policy\_attached\_id](#output\_iam\_user\_policy\_attached\_id) | The list of attached policy IDs. |
| <a name="output_iam_user_policy_attached_policy_arn"></a> [iam\_user\_policy\_attached\_policy\_arn](#output\_iam\_user\_policy\_attached\_policy\_arn) | The list of attached policy ARNs. |
| <a name="output_iam_user_policy_inline_id"></a> [iam\_user\_policy\_inline\_id](#output\_iam\_user\_policy\_inline\_id) | The list of inline policy IDs. |
| <a name="output_iam_user_policy_inline_name"></a> [iam\_user\_policy\_inline\_name](#output\_iam\_user\_policy\_inline\_name) | The list of inline policy names. |
| <a name="output_iam_user_policy_inline_policy"></a> [iam\_user\_policy\_inline\_policy](#output\_iam\_user\_policy\_inline\_policy) | The list of inline policy documents. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
