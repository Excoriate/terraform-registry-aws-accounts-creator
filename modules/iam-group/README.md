<!-- BEGIN_TF_DOCS -->
# ☁️ AWS IAM Groups
## Description

For more information about this module's capabilities, please refer to: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source     = "../../../modules/iam-group"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  groups_config = var.groups_config
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
output "groups_created" {
  value       = local.groups_normalised
  description = "List of groups that were passed to this module, and created in AWS."
}

output "groups_created_count" {
  value       = length(local.groups_normalised)
  description = "Number of groups that were passed to this module, and created in AWS."
}

output "groups_created_ids" {
  value       = join("", [for group in aws_iam_group.this : group.id])
  description = "List of IDs of groups that were passed to this module, and created in AWS."
}

output "groups_created_names" {
  value       = join("", [for group in aws_iam_group.this : group.name])
  description = "List of names of groups that were passed to this module, and created in AWS."
}

output "groups_created_arns" {
  value       = join("", [for group in aws_iam_group.this : group.arn])
  description = "List of ARNs of groups that were passed to this module, and created in AWS."
}
```
---

## Module's documentation
(This documentation is auto-generated using [terraform-docs](https://terraform-docs.io))
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.52.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_groups_config"></a> [groups\_config](#input\_groups\_config) | A list of objects containing the name and path of the groups to be created.<br>The 'path' attribute is optional. An example of this input variable is:<br>[<br>  {<br>    name = "group1"<br>    path = "/path1/"<br>  },<br>  {<br>    name = "group2"<br>    path = "/path2/"<br>  }<br>]<br>For a more detailed documentation, please refer to: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group | <pre>list(object({<br>    name = string<br>    path = optional(string, "")<br>  }))</pre> | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_groups_created"></a> [groups\_created](#output\_groups\_created) | List of groups that were passed to this module, and created in AWS. |
| <a name="output_groups_created_arns"></a> [groups\_created\_arns](#output\_groups\_created\_arns) | List of ARNs of groups that were passed to this module, and created in AWS. |
| <a name="output_groups_created_count"></a> [groups\_created\_count](#output\_groups\_created\_count) | Number of groups that were passed to this module, and created in AWS. |
| <a name="output_groups_created_ids"></a> [groups\_created\_ids](#output\_groups\_created\_ids) | List of IDs of groups that were passed to this module, and created in AWS. |
| <a name="output_groups_created_names"></a> [groups\_created\_names](#output\_groups\_created\_names) | List of names of groups that were passed to this module, and created in AWS. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->