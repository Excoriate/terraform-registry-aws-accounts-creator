<!-- BEGIN_TF_DOCS -->
# ☁️ AWS IAM Group permissions
## Description

For more information about this module's capabilities, please refer to: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.
This module:
* ✅ Create an `IAM` policy to generate permissions for a certain IAM group.
* ✅ Create an `IAM` policy attachment.
>Note: This module assumes that the IAM group already exists.

```hcl
module "main_module" {
  source     = "../../../modules/iam-group-permissions"
  is_enabled = var.is_enabled
  aws_region = var.aws_region
  group_permissions_config = [
    {
      group_name = "admin"
      policy = jsonencode({
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Effect" : "Allow",
            "Action" : [
              "ec2:*"
            ],
            "Resource" : "*"
          }
        ]
      })
    }
  ]
}
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
output "group_policy_id" {
  value       = join("", [for p in aws_iam_group_policy.this : p.id])
  description = "The ID of the group policy."
}

output "group_policy_name" {
  value       = join("", [for p in aws_iam_group_policy.this : p.name])
  description = "The name of the group policy."
}

output "group_policy_policy" {
  value       = join("", [for p in aws_iam_group_policy.this : p.policy])
  description = "The policy document."
}

output "group_policy_group" {
  value       = join("", [for p in aws_iam_group_policy.this : p.group])
  description = "The group the policy is attached to."
}
```
---

## Module's documentation
(This documentation is auto-generated using [terraform-docs](https://terraform-docs.io))
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.48.0, < 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_group_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy) | resource |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_group_permissions_config"></a> [group\_permissions\_config](#input\_group\_permissions\_config) | A list of objects that contains the group name and the policy to attach to the group. | <pre>list(object({<br>    group_name = string<br>    policy= string<br>  }))</pre> | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_group_policy_group"></a> [group\_policy\_group](#output\_group\_policy\_group) | The group the policy is attached to. |
| <a name="output_group_policy_id"></a> [group\_policy\_id](#output\_group\_policy\_id) | The ID of the group policy. |
| <a name="output_group_policy_name"></a> [group\_policy\_name](#output\_group\_policy\_name) | The name of the group policy. |
| <a name="output_group_policy_policy"></a> [group\_policy\_policy](#output\_group\_policy\_policy) | The policy document. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->