<!-- BEGIN_TF_DOCS -->
# ☁️ AWS System user
## Description

This module generates a system user. What's a system user? - It's an user that's used by a system, not a human. It's a user that's used by a service, or a system, to perform actions on AWS. It's not a user that's used by a human to log in to the AWS console.
Examples of system users:
- A CI/CD system that needs to deploy code to AWS.
- A service that needs to perform actions on AWS.
- A system that needs to perform actions on AWS.
- A human that needs to perform actions on AWS, but doesn't want to use their own credentials.
- A human that needs to perform actions on AWS, but doesn't want to use their own credentials, and doesn't want to use a shared account.

This module takes care of creating the user, attaching the policies, and generating the access keys. It doesn't store the credentials anywhere, it's up to you to store them in a secure place.
Nevertheless, it can be easily composed with other modules to store the credentials in a secure place, like AWS Secrets Manager, or AWS SSM Parameter Store.

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source                      = "../../../modules/iam-system-user"
  is_enabled                  = var.is_enabled
  aws_region                  = var.aws_region
  iam_user_credentials_config = var.iam_user_credentials_config
  iam_user_config             = var.iam_user_config
  iam_user_permissions_config = var.iam_user_permissions_config
  tags = {
    Environment = "test"
    ManagedBy   = "terraform"
    Source      = "Example-Recipe"
  }
}
```

Creating a basic system user:
```hcl
aws_region = "us-east-1"
is_enabled = true

iam_user_config = [
  {
    name = "testuser"
  }
]

```
Creating a system user that has AWS keys:
```hcl
aws_region = "us-east-1"
is_enabled = true

iam_user_config = [
  {
    name = "user-with-keys"
  }
]

iam_user_credentials_config = [
  {
    name    = "user-with-keys"
    enabled = true
  }
]


iam_user_permissions_config = [
  {
    name               = "user-with-keys"
    policy_inline_json = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "S3BucketPolicy",
      "Effect": "Allow",
      "Action": [
       "s3:ListBucket",
        "s3:GetBucketLocation"
      ],
      "Resource": "*"
    }
  ]
}
EOF
  },
]

```
Creating multiple users with AWS credentials included:
```hcl
aws_region = "us-east-1"
is_enabled = true

iam_user_config = [
  {
    name = "user-with-keys"
  },
  {
    name = "another-with-keys"
  },
  {
    name = "user-without-keys"
  }
]

iam_user_credentials_config = [
  {
    name    = "user-with-keys"
    enabled = true
  },
  {
    name    = "another-with-keys"
    enabled = true
    status  = "Inactive"
  }
]


iam_user_permissions_config = [
  {
    name               = "user-with-keys"
    policy_inline_json = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "S3BucketPolicy",
      "Effect": "Allow",
      "Action": [
       "s3:ListBucket",
        "s3:GetBucketLocation"
      ],
      "Resource": "*"
    }
  ]
}
EOF
  },
]

```
Creating a system user with a custom inline policy:
```hcl
aws_region = "us-east-1"
is_enabled = true

iam_user_config = [
  {
    name = "testuser"
  }
]

iam_user_permissions_config = [
  {
    name               = "testuser"
    policy_inline_json = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:AttachVolume",
        "ec2:DetachVolume",
        "ec2:DeleteVolume"
      ],
      "Resource": "*"
    }
  ]
}
EOF
  }
]

```
Creating several users with policies:
```hcl
aws_region = "us-east-1"
is_enabled = true

iam_user_config = [
  {
    name = "testuser"
  },
  {
    name = "another-user"
  }
]

iam_user_permissions_config = [
  {
    name               = "another-user"
    policy_inline_json = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "S3BucketPolicy",
      "Effect": "Allow",
      "Action": [
       "s3:ListBucket",
        "s3:GetBucketLocation"
      ],
      "Resource": "*"
    }
  ]
}
EOF
  },
  {
    name               = "testuser"
    policy_inline_json = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:AttachVolume",
        "ec2:DetachVolume",
        "ec2:DeleteVolume"
      ],
      "Resource": "*"
    }
  ]
}
EOF
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
output "iam_user_id" {
  value       = [for user in aws_iam_user.this : user.id]
  description = "The ID of the IAM user."
}

output "iam_user_arn" {
  value       = [for user in aws_iam_user.this : user.arn]
  description = "The ARN of the IAM user."
}

output "iam_user_name" {
  value       = [for user in aws_iam_user.this : user.name]
  description = "The name of the IAM user."
}

output "iam_user_path" {
  value       = [for user in aws_iam_user.this : user.path]
  description = "The path of the IAM user."
}

output "iam_user_permissions_boundary" {
  value       = [for user in aws_iam_user.this : user.permissions_boundary]
  description = "The ARN of the policy that is used to set the permissions boundary for the user."
}

output "iam_user_policy_inline_id" {
  value       = [for p in aws_iam_user_policy.inline : p.id]
  description = "The list of inline policy IDs."
}

output "iam_user_policy_inline_name" {
  value       = [for p in aws_iam_user_policy.inline : p.name]
  description = "The list of inline policy names."
}

output "iam_user_policy_inline_policy" {
  value       = [for p in aws_iam_user_policy.inline : p.policy]
  description = "The list of inline policy documents."
}

output "iam_user_policy_attached_id" {
  value       = [for p in aws_iam_user_policy_attachment.attached_policy : p.id]
  description = "The list of attached policy IDs."
}

output "iam_user_policy_attached_policy_arn" {
  value       = [for p in aws_iam_user_policy_attachment.attached_policy : p.policy_arn]
  description = "The list of attached policy ARNs."
}

output "iam_user_key_id" {
  value       = [for k in aws_iam_access_key.this : k.id]
  description = "The list of access key IDs."
  sensitive   = true
}

output "iam_user_key_status" {
  value       = [for k in aws_iam_access_key.this : k.status]
  description = "The list of access key statuses."
}

output "iam_user_key_secret" {
  value       = [for k in aws_iam_access_key.this : k.secret]
  description = "The list of access key secrets."
  sensitive   = true
}
```
---

## Module's documentation
(This documentation is auto-generated using [terraform-docs](https://terraform-docs.io))
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.61.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.inline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_iam_user_policy_attachment.attached_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

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
