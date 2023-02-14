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
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../modules/iam-role | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | n/a | yes |
| <a name="input_iam_role_config"></a> [iam\_role\_config](#input\_iam\_role\_config) | A list of objects that contains the configuration for the IAM Role to be created.<br>  Each object in the list represents a single IAM Role. The following attributes are supported:<br>- name: Name of the IAM Role to be created.<br>- path: Path of the IAM Role to be created.<br>- description: Description of the IAM Role to be created.<br>- permissions\_boundary: The ARN of the policy that is used to set the permissions boundary for the IAM Role.<br>- max\_session\_duration: The maximum session duration (in seconds) that you want to set for the specified role.<br>- iam\_policy\_documents\_json: A list of IAM Policy documents in JSON format.<br>- assume\_role\_config: A map of objects that contains the configuration for the IAM Role to be created.<br>  Each object in the list represents a single IAM Role. The following attributes are supported:<br>  - principals: A map of lists that contains the AWS principals that are allowed to assume the IAM Role.<br>  - actions: A list of strings that contains the AWS actions that are allowed to assume the IAM Role.<br>  - conditions: A list of objects that contains the conditions that are allowed to assume the IAM Role.<br>    Each object in the list represents a single condition. The following attributes are supported:<br>    - test: The test that is applied to the condition.<br>    - variable: The variable that is used in the condition.<br>    - values: A list of strings that contains the values that are used in the condition. | <pre>list(object({<br>    name                      = string<br>    path                      = optional(string, "/")<br>    description               = optional(string, "No description given to this IAM Role")<br>    permissions_boundary      = optional(string, null)<br>    max_session_duration      = optional(number, 3600)<br>    iam_policy_documents_json = optional(list(string), [])<br>    default_iam_policy_json   = optional(string, null)<br>    assume_role_config = object({<br>      principals = optional(list(object({<br>        type        = optional(string, "Service")<br>        identifiers = list(string)<br>      })), [])<br>      actions = optional(list(string), [])<br>      conditions = optional(list(object({<br>        test     = string<br>        variable = string<br>        values   = list(string)<br>      })), [])<br>    })<br>  }))</pre> | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Enable or disable the module | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | The ARN of the IAM role. |
| <a name="output_iam_role_description"></a> [iam\_role\_description](#output\_iam\_role\_description) | The description of the IAM role. |
| <a name="output_iam_role_force_detach_policies"></a> [iam\_role\_force\_detach\_policies](#output\_iam\_role\_force\_detach\_policies) | Specifies to force detaching any policies the role has before destroying it. |
| <a name="output_iam_role_id"></a> [iam\_role\_id](#output\_iam\_role\_id) | The ID of the IAM role. |
| <a name="output_iam_role_max_session_duration"></a> [iam\_role\_max\_session\_duration](#output\_iam\_role\_max\_session\_duration) | The maximum session duration (in seconds) that you want to set for the specified role. |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | The name of the IAM role. |
| <a name="output_iam_role_path"></a> [iam\_role\_path](#output\_iam\_role\_path) | The path to the role. |
| <a name="output_iam_role_permissions_boundary"></a> [iam\_role\_permissions\_boundary](#output\_iam\_role\_permissions\_boundary) | The ARN of the policy that is used to set the permissions boundary for the role. |
| <a name="output_iam_role_unique_id"></a> [iam\_role\_unique\_id](#output\_iam\_role\_unique\_id) | The stable and unique string identifying the role. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
