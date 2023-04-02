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
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../modules/iam-policy | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | n/a | yes |
| <a name="input_iam_policy_config"></a> [iam\_policy\_config](#input\_iam\_policy\_config) | A list of objects that contains the configuration of the IAM policies to be created.<br>  Each object in the list represents a single IAM policy. The current supported options are:<br>  - name: The name of the IAM policy.<br>  - path: The path of the IAM policy.<br>  - policy\_document\_id: The ID of the IAM policy document to be used. If this is not provided, the module will create a new IAM policy document.<br>  - description: The description of the IAM policy.<br>If this is not provided, the module will create a new IAM policy document.<br>  - statements: A list of objects that contains the configuration of the IAM policy statements to be created.<br>  Each object in the list represents a single IAM policy statement. The current supported options are:<br>  - sid: The SID of the IAM policy statement.<br>  - effect: The effect of the IAM policy statement.<br>  - actions: A list of actions to be allowed or denied by the IAM policy statement.<br>  - not\_actions: A list of actions to be denied by the IAM policy statement.<br>  - resources: A list of resources to be allowed or denied by the IAM policy statement.<br>  - not\_resources: A list of resources to be denied by the IAM policy statement.<br>  - not\_principals: A list of objects that contains the configuration of the IAM policy statement not principals.<br>  Each object in the list represents a single IAM policy statement not principal. The current supported options are:<br>  - type: The type of the IAM policy statement not principal.<br>  - identifiers: A list of identifiers of the IAM policy statement not principal.<br>  - principals: A list of objects that contains the configuration of the IAM policy statement principals.<br>  Each object in the list represents a single IAM policy statement principal. The current supported options are:<br>  - type: The type of the IAM policy statement principal.<br>  - identifiers: A list of identifiers of the IAM policy statement principal.<br>  - condition: A list of objects that contains the configuration of the IAM policy statement condition.<br>  Each object in the list represents a single IAM policy statement condition. The current supported options are:<br>  - test: The test of the IAM policy statement condition.<br>  - variable: The variable of the IAM policy statement condition.<br>  - values: A list of values of the IAM policy statement condition.<br>  - source\_policy\_documents: A list of IDs of the IAM policy documents to be used as source for the IAM policy.<br>  - override\_policy\_documents: A list of IDs of the IAM policy documents to be used as override for the IAM policy. | <pre>list(object({<br>    name               = string<br>    policy_document_id = optional(string, null)<br>    path               = optional(string, "/")<br>    description        = optional(string, "No description given to this IAM policy")<br>    statements = optional(list(object({<br>      sid           = string // Required.<br>      effect        = optional(string, null)<br>      actions       = optional(list(string), null)<br>      not_actions   = optional(list(string), null)<br>      resources     = optional(list(string), null)<br>      not_resources = optional(list(string), null)<br>      // Optional block during the formation of the IAM policy.<br>      not_principals = optional(list(object({<br>        type        = string<br>        identifiers = list(string)<br>      })), null)<br>      // Optional block during the formation of the IAM policy.<br>      principals = optional(list(object({<br>        type        = string<br>        identifiers = list(string)<br>      })), null)<br>      // Optional block during the formation of the IAM policy.<br>      conditions = optional(list(object({<br>        test     = string<br>        variable = string<br>        values   = list(string)<br>      })), null)<br>    })), null)<br>    source_policy_documents   = optional(list(string), [])<br>    override_policy_documents = optional(list(string), [])<br>  }))</pre> | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Enable or disable the module | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_iam_policy_arn"></a> [iam\_policy\_arn](#output\_iam\_policy\_arn) | The ARN of the IAM policy. |
| <a name="output_iam_policy_description"></a> [iam\_policy\_description](#output\_iam\_policy\_description) | The description of the IAM policy. |
| <a name="output_iam_policy_id"></a> [iam\_policy\_id](#output\_iam\_policy\_id) | The ID of the IAM policy. |
| <a name="output_iam_policy_name"></a> [iam\_policy\_name](#output\_iam\_policy\_name) | The name of the IAM policy. |
| <a name="output_iam_policy_path"></a> [iam\_policy\_path](#output\_iam\_policy\_path) | The path of the IAM policy. |
| <a name="output_iam_policy_policy"></a> [iam\_policy\_policy](#output\_iam\_policy\_policy) | The policy of the IAM policy. |
| <a name="output_iam_policy_policy_id"></a> [iam\_policy\_policy\_id](#output\_iam\_policy\_policy\_id) | The policy ID of the IAM policy. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
