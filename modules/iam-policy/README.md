<!-- BEGIN_TF_DOCS -->
# ☁️ AWS IAM Policy
## Description

This module creates en AWS IAM Policy, with the following capabilities:
- Create a Policy
- Specify the policy document
For more information about this AWS configuration, please refer to its official documentation: [AWS IAM Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)
In terms of terraform, please query its official terraform-registry documentation for more information: [Terraform AWS IAM Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source     = "../../../modules/iam-policy"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  iam_policy_config = var.iam_policy_config
}
```

An example of passing a more complex set of functions to this role.
```hcl
aws_region = "us-east-1"
is_enabled = true

iam_policy_config = [
  {
    name = "test-policy"
    statements = [
      {
        sid    = "teststatement1"
        effect = "Allow"
        actions = [
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation"
        ]
        resources = [
          "arn:aws:s3:::*"
        ]
      }
    ]
  }
]
```
For module composition, It's recommended to take a look at the module's `outputs` to understand what's available:
```hcl
output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "aws_region_for_deploy_this" {
  value       = local.aws_region_to_deploy
  description = "The AWS region where the module is deployed."
}

output "tags_set" {
  value       = var.tags
  description = "The tags set for the module."
}

/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "iam_policy_arn" {
  value       = [for p in aws_iam_policy.this : p.arn]
  description = "The ARN of the IAM policy."
}

output "iam_policy_id" {
  value       = [for p in aws_iam_policy.this : p.id]
  description = "The ID of the IAM policy."
}

output "iam_policy_name" {
  value       = [for p in aws_iam_policy.this : p.name]
  description = "The name of the IAM policy."
}

output "iam_policy_description" {
  value       = [for p in aws_iam_policy.this : p.description]
  description = "The description of the IAM policy."
}

output "iam_policy_path" {
  value       = [for p in aws_iam_policy.this : p.path]
  description = "The path of the IAM policy."
}

output "iam_policy_policy" {
  value       = [for p in aws_iam_policy.this : p.policy]
  description = "The policy of the IAM policy."
}

output "iam_policy_policy_id" {
  value       = [for p in aws_iam_policy.this : p.policy_id]
  description = "The policy ID of the IAM policy."
}
```
---

## Module's documentation
(This documentation is auto-generated using [terraform-docs](https://terraform-docs.io))
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.54.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_iam_policy_config"></a> [iam\_policy\_config](#input\_iam\_policy\_config) | A list of objects that contains the configuration of the IAM policies to be created.<br>  Each object in the list represents a single IAM policy. The current supported options are:<br>  - name: The name of the IAM policy.<br>  - policy\_document\_id: The ID of the IAM policy document to be used. If this is not provided, the module will create a new IAM policy document.<br>  - path: The path of the IAM policy.<br>  - description: The description of the IAM policy.<br>If this is not provided, the module will create a new IAM policy document.<br>  - statements: A list of objects that contains the configuration of the IAM policy statements to be created.<br>  Each object in the list represents a single IAM policy statement. The current supported options are:<br>  - sid: The SID of the IAM policy statement.<br>  - effect: The effect of the IAM policy statement.<br>  - actions: A list of actions to be allowed or denied by the IAM policy statement.<br>  - not\_actions: A list of actions to be denied by the IAM policy statement.<br>  - resources: A list of resources to be allowed or denied by the IAM policy statement.<br>  - not\_resources: A list of resources to be denied by the IAM policy statement.<br>  - not\_principals: A list of objects that contains the configuration of the IAM policy statement not principals.<br>  Each object in the list represents a single IAM policy statement not principal. The current supported options are:<br>  - type: The type of the IAM policy statement not principal.<br>  - identifiers: A list of identifiers of the IAM policy statement not principal.<br>  - principals: A list of objects that contains the configuration of the IAM policy statement principals.<br>  Each object in the list represents a single IAM policy statement principal. The current supported options are:<br>  - type: The type of the IAM policy statement principal.<br>  - identifiers: A list of identifiers of the IAM policy statement principal.<br>  - condition: A list of objects that contains the configuration of the IAM policy statement condition.<br>  Each object in the list represents a single IAM policy statement condition. The current supported options are:<br>  - test: The test of the IAM policy statement condition.<br>  - variable: The variable of the IAM policy statement condition.<br>  - values: A list of values of the IAM policy statement condition.<br>  - source\_policy\_documents: A list of IDs of the IAM policy documents to be used as source for the IAM policy.<br>  - override\_policy\_documents: A list of IDs of the IAM policy documents to be used as override for the IAM policy. | <pre>list(object({<br>    name               = string<br>    policy_document_id = optional(string, null)<br>    path               = optional(string, "/")<br>    description        = optional(string, "No description given to this IAM policy")<br>    statements = optional(list(object({<br>      sid           = string // Required.<br>      effect        = optional(string, null)<br>      actions       = optional(list(string), null)<br>      not_actions   = optional(list(string), null)<br>      resources     = optional(list(string), null)<br>      not_resources = optional(list(string), null)<br>      // Optional block during the formation of the IAM policy.<br>      not_principals = optional(list(object({<br>        type        = string<br>        identifiers = list(string)<br>      })), null)<br>      // Optional block during the formation of the IAM policy.<br>      principals = optional(list(object({<br>        type        = string<br>        identifiers = list(string)<br>      })), null)<br>      // Optional block during the formation of the IAM policy.<br>      conditions = optional(list(object({<br>        test     = string<br>        variable = string<br>        values   = list(string)<br>      })), null)<br>    })), null)<br>    source_policy_documents   = optional(list(string), [])<br>    override_policy_documents = optional(list(string), [])<br>  }))</pre> | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

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