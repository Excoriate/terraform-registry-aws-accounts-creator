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
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../modules/iam-group | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | n/a | yes |
| <a name="input_groups_config"></a> [groups\_config](#input\_groups\_config) | A list of objects containing the name and path of the groups to be created.<br>The 'path' attribute is optional. An example of this input variable is:<br>[<br>  {<br>    name = "group1"<br>    path = "/path1/"<br>  },<br>  {<br>    name = "group2"<br>    path = "/path2/"<br>  }<br>]<br>For a more detailed documentation, please refer to: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group | <pre>list(object({<br>    name = string<br>    path = optional(string)<br>  }))</pre> | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Enable or disable the module | `bool` | n/a | yes |

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
