<!-- BEGIN_TF_DOCS -->
# ☁️ AWS IAM Policy attacher
## Description

This module is used to attach an IAM policy to a role or user. The current capabilities that are supported are:
- Attach a policy to a role
- Attach a policy to a user
- Attach a policy to a group

For more information about this specific resource, please refer to the [AWS documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_manage-attach-detach.html).

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source     = "../../../modules/iam-policy-attacher"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  config = [{
    name = "test-attachment"
    role = aws_iam_role.role.name
    policy_arn = aws_iam_policy.policy.arn
  }]
}

resource "aws_iam_role" "role" {
  name = "test-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
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
output "iam_policy_attachment_name" {
  value       = [for policy_attachment in aws_iam_policy_attachment.this : policy_attachment.name]
  description = "The name of the IAM policy attachment."
}

output "iam_policy_attachment_id" {
  value       = [for policy_attachment in aws_iam_policy_attachment.this : policy_attachment.id]
  description = "The ID of the IAM policy attachment."
}
```
---

## Module's documentation
(This documentation is auto-generated using [terraform-docs](https://terraform-docs.io))
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.55.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_config"></a> [config](#input\_config) | The configuration for the IAM policy attacher. The current configuration allowed are:<br>  - name - The name of the IAM policy attacher<br>  - users - The list of IAM users to attach the policy to<br>  - role - The IAM role to attach the policy to<br>  - groups - The list of IAM groups to attach the policy to<br>  - policy\_arn - The ARN of the IAM policy to attach | <pre>list(object({<br>    name       = string<br>    users      = optional(list(string))<br>    role       = string<br>    groups     = optional(list(string))<br>    policy_arn = string<br>  }))</pre> | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_iam_policy_attachment_id"></a> [iam\_policy\_attachment\_id](#output\_iam\_policy\_attachment\_id) | The ID of the IAM policy attachment. |
| <a name="output_iam_policy_attachment_name"></a> [iam\_policy\_attachment\_name](#output\_iam\_policy\_attachment\_name) | The name of the IAM policy attachment. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
