<!-- BEGIN_TF_DOCS -->
# ☁️ AWS IAM Rol
## Description

This module creates an IAM Role, with a given set of policies attached to it. For more information about IAM Roles, please refer to the [official documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html).
The following capabilities are supported:
- Create a role with a given set of policies.
- Create an assume role policy document, with a given set of principals.
- Supports the creation of a default IAM policy, if passed. If not, it'll create an stand-alone IAM role without a policy.
- Supports thea attachment of N IAM policies (documents, in .json) passed as a list to the role.

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source     = "../../../modules/iam-role"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  iam_role_config = var.iam_role_config
}
```

An example of passing a more complex set of functions to this role.
```hcl
aws_region = "us-east-1"
is_enabled = true

// Very simple usage.
iam_role_config = [
  {
    name = "my-test-role"
    assume_role_config = {
      principals = [
        {
          type        = "Service"
          identifiers = ["ec2.amazonaws.com"]
        }
      ]
    }
  }
]
```
```hcl
aws_region = "us-east-1"
is_enabled = true

// Very simple usage.
iam_role_config = [
  {
    name = "my-test-role"
    assume_role_config = {
      principals = [
        {
          type        = "Service"
          identifiers = ["ec2.amazonaws.com"]
        }
      ]
      actions = [
        "elasticloadbalancing:Describe*",
        "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
        "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
        "ec2:Describe*",
        "ec2:AuthorizeSecurityGroupIngress",
        "elasticloadbalancing:RegisterTargets",
        "elasticloadbalancing:DeregisterTargets"
      ]
    }
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
output "iam_role_id" {
  value       = [for role in aws_iam_role.this : role.id]
  description = "The ID of the IAM role."
}

output "iam_role_arn" {
  value       = [for role in aws_iam_role.this : role.arn]
  description = "The ARN of the IAM role."
}

output "iam_role_name" {
  value       = [for role in aws_iam_role.this : role.name]
  description = "The name of the IAM role."
}

output "iam_role_unique_id" {
  value       = [for role in aws_iam_role.this : role.unique_id]
  description = "The stable and unique string identifying the role."
}

output "iam_role_description" {
  value       = [for role in aws_iam_role.this : role.description]
  description = "The description of the IAM role."
}

output "iam_role_force_detach_policies" {
  value       = [for role in aws_iam_role.this : role.force_detach_policies]
  description = "Specifies to force detaching any policies the role has before destroying it."
}

output "iam_role_max_session_duration" {
  value       = [for role in aws_iam_role.this : role.max_session_duration]
  description = "The maximum session duration (in seconds) that you want to set for the specified role."
}

output "iam_role_path" {
  value       = [for role in aws_iam_role.this : role.path]
  description = "The path to the role."
}

output "iam_role_permissions_boundary" {
  value       = [for role in aws_iam_role.this : role.permissions_boundary]
  description = "The ARN of the policy that is used to set the permissions boundary for the role."
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
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.default_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.iam_policy_documents](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_aggregated](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.extra_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_iam_role_config"></a> [iam\_role\_config](#input\_iam\_role\_config) | A list of objects that contains the configuration for the IAM Role to be created.<br>  Each object in the list represents a single IAM Role. The following attributes are supported:<br>- name: Name of the IAM Role to be created.<br>- path: Path of the IAM Role to be created.<br>- description: Description of the IAM Role to be created.<br>- permissions\_boundary: The ARN of the policy that is used to set the permissions boundary for the IAM Role.<br>- max\_session\_duration: The maximum session duration (in seconds) that you want to set for the specified role.<br>- iam\_policy\_documents\_json: A list of IAM Policy documents in JSON format.<br>- assume\_role\_config: A map of objects that contains the configuration for the IAM Role to be created.<br>  Each object in the list represents a single IAM Role. The following attributes are supported:<br>  - principals: A map of lists that contains the AWS principals that are allowed to assume the IAM Role.<br>  - actions: A list of strings that contains the AWS actions that are allowed to assume the IAM Role.<br>  - conditions: A list of objects that contains the conditions that are allowed to assume the IAM Role.<br>    Each object in the list represents a single condition. The following attributes are supported:<br>    - test: The test that is applied to the condition.<br>    - variable: The variable that is used in the condition.<br>    - values: A list of strings that contains the values that are used in the condition. | <pre>list(object({<br>    name                      = string<br>    path                      = optional(string, "/")<br>    description               = optional(string, "No description given to this IAM Role")<br>    permissions_boundary      = optional(string, null)<br>    max_session_duration      = optional(number, 3600)<br>    iam_policy_documents_json = optional(list(string), [])<br>    default_iam_policy_json   = optional(string, null)<br>    assume_role_config = object({<br>      principals = optional(list(object({<br>        type        = optional(string, "Service")<br>        identifiers = list(string)<br>      })), [])<br>      actions = optional(list(string), [])<br>      conditions = optional(list(object({<br>        test     = string<br>        variable = string<br>        values   = list(string)<br>      })), [])<br>    })<br>  }))</pre> | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

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
