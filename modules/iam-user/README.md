<!-- BEGIN_TF_DOCS -->
# ☁️ AWS IAM Users
## Description

For more information, please refer to the [module's documentation](https://registry.terraform.io/modules/terraform-aws-modules/iam/aws/latest/submodules/iam-users).

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source     = "../../../modules/iam-user"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  // User configuration
  pgp_key                        = var.pgp_key
  users_config                   = var.users_config
  global_groups                  = var.global_groups
  global_password_length         = var.global_password_length
  global_password_reset_required = var.global_password_reset_required
  global_permission_boundary     = var.global_permission_boundary
}
```

Follow these instructions after creation, in order to activate/user a given user created by this module:
1. The user will be created normally after a proper `terraform apply` command.
2. Once the command finished, it'll `output` the encrypted password. Check the output `keybase_password_decrypt_command`. E.g.:
```Text
- keybase_password_decrypt_command      = <<-EOT
echo "wcFMAxXN0J1RhIFJAQ/9ED6VZeaFENxGb3En8KsqAv7b6Cni6Nf7fCoJsVt8uXbmLvIhVAuZhPIwfCxyLa6PTCoLZKcatsh6fE9xteAF5LiAbYWW4AV7mdX8V17X1BqaHFk4FBL4f7855IvLj77IKobzzTihCu/uMcmyjNZCYmEEUh7FTGuVxwzKpdO/
kkLEDK5RyrLHAfOr+6flPPVBMJH+faaXTuc5EGQORSmEa142QAjOnZfX6lD3WgFAJiTgvQQUoacwmfkY6szO1yEdDDyJNcpCib3+wajGOeUej8+eEB8xwsyRoMlhDzce9X4QER6z4n5Uv5vrt6UXzF19ehlw0V4ndTRWeXTF0cIiW0LJgHl8wk0tY1TMImbJmBm
/r+56Rg45IwkwA9jwiAhzdWXlovTE4FQ5wGU2IIGmtvdRgAzr2dEF5Hj5JkkNR4tRfZbKraghHhL6pnnaibP4rw6WbQDz8ZnLcvTzykKGhOC4TEpElJeFpnDAtm1lSnb3AaKLx/UCMaN6c+lJ3Bea2ifvld8fI8i96TQhzAc9RDdjzeLZ+b77hS7jNoFF4cq6A08
rj1dV8+N0bkPp+eFEmyYxo+raZtTcb2OVMALpA3v0nA1eCZxBnDSSQFWJ6lnd0meyG9Lue6mhv8lMW1MF81taJuDI23EQ5da7hwk06V9OmnKHecC7pMHkWzulE9Em2+5z/KzDHkPG9NTBlkah4sF2LE=" | base64 --decode | keybase pgp decrypt
```
3. Ensure that you have [KeyBase](https://keybase.io/) installed and configured. If not, please follow the [instructions](https://keybase.io/download).
4. Copy the command from the output and paste it in your terminal. It'll ask you for your KeyBase passphrase. After that, it'll output the decrypted password.
5. Use the decrypted password to login to the AWS console.
>Note: The `keybase` user should be an existing user, and must be configured beforehand.

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
output "user_name" {
  value       = join("", [for user in aws_iam_user.this : user.name])
  description = "The user name of the user."
}

output "user_arn" {
  value       = join("", [for user in aws_iam_user.this : user.arn])
  description = "The ARN of the user."
}

output "user_unique_id" {
  value       = join("", [for user in aws_iam_user.this : user.unique_id])
  description = "The unique ID assigned by AWS."
}

output "user_path" {
  value       = join("", [for user in aws_iam_user.this : user.path])
  description = "The path to the user."
}

output "user_login_profile_encrypted_password" {
  value       = join("", [for user in aws_iam_user_login_profile.this : user.encrypted_password])
  description = "The encrypted password for the user."
}

output "user_login_profile_key_fingerprint" {
  value       = join("", [for user in aws_iam_user_login_profile.this : user.key_fingerprint])
  description = "The MD5 message digest of the key used to encrypt the password."
}

output "pgp_key" {
  value       = var.pgp_key
  description = "The PGP key to use to encrypt the password."
}

output "keybase_password_decrypt_command" {
  # https://stackoverflow.com/questions/36565256/set-the-aws-console-password-for-iam-user-with-terraform
  description = "Command to decrypt the Keybase encrypted password. Returns empty string if pgp_key is not from keybase"
  value       = local.keybase_password_decrypt_command
}

output "keybase_password_pgp_message" {
  description = "PGP encrypted message (e.g. suitable for email exchanges). Returns empty string if pgp_key is not from keybase"
  value       = local.keybase_password_pgp_message
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
| [aws_iam_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_group_membership.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |
| [aws_iam_user_login_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_login_profile) | resource |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_global_groups"></a> [global\_groups](#input\_global\_groups) | A list of groups that'll be added to all users. This can be set either individually for each user<br>or globally for all users. If this variable is set, it'll take precedence over the value set in the<br>'groups' attribute of the var.users\_config variable. | `list(string)` | `null` | no |
| <a name="input_global_password_length"></a> [global\_password\_length](#input\_global\_password\_length) | The length of the generated password. This can be set either individually for each user or<br>globally for all users. If this variable is set, it'll take precedence over the value set in the<br>'password\_length' attribute of the var.users\_config variable. | `number` | `null` | no |
| <a name="input_global_password_reset_required"></a> [global\_password\_reset\_required](#input\_global\_password\_reset\_required) | Whether the generated password should be reset on the first login. This is useful when you want<br>  to force the user to change the password on the first login. This can be set either<br>individually for each user or globally for all users. If this variable is set, it'll take precedence<br>over the value set in the 'password\_reset\_required' variable. | `bool` | `null` | no |
| <a name="input_global_permission_boundary"></a> [global\_permission\_boundary](#input\_global\_permission\_boundary) | A global permission boundary that'll be applied to all users | `string` | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_pgp_key"></a> [pgp\_key](#input\_pgp\_key) | A PGP key that'll be used to encrypt the generated password. This is useful when you want to<br>  share the generated password with other users. The generated password will be encrypted using<br>  the provided PGP key. The encrypted password will be stored in the Terraform state file. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_users_config"></a> [users\_config](#input\_users\_config) | A list that defines a set of users that'll be created. These users are actual 'Console/Human' users<br>  and not service accounts. E.g.: Simple configuration that'll create two users<br>  users\_config = [<br>    {<br>      email = "someone@example.com",<br>      force\_destroy: true,<br>      path: "/devops/"<br>    },<br>    {<br>      email = "someone@example.com",<br>      force\_destroy: true,<br>      path: "/devops/"<br>      password\_length: 32,<br>      password\_reset\_required: false,<br>      groups: ["devops", "developers"],<br>    },<br>  ]<br>For more details about this resource, please refer to: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user | <pre>list(object({<br>    email                   = string // Will be user as an user-name<br>    force_destroy           = optional(bool, false)<br>    path                    = optional(string, "/")<br>    permissions_boundary    = optional(string, null)<br>    password_reset_required = optional(bool, true)<br>    password_length         = optional(number, 24)<br>    groups                  = optional(list(string), [])<br>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_keybase_password_decrypt_command"></a> [keybase\_password\_decrypt\_command](#output\_keybase\_password\_decrypt\_command) | Command to decrypt the Keybase encrypted password. Returns empty string if pgp\_key is not from keybase |
| <a name="output_keybase_password_pgp_message"></a> [keybase\_password\_pgp\_message](#output\_keybase\_password\_pgp\_message) | PGP encrypted message (e.g. suitable for email exchanges). Returns empty string if pgp\_key is not from keybase |
| <a name="output_pgp_key"></a> [pgp\_key](#output\_pgp\_key) | The PGP key to use to encrypt the password. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
| <a name="output_user_arn"></a> [user\_arn](#output\_user\_arn) | The ARN of the user. |
| <a name="output_user_login_profile_encrypted_password"></a> [user\_login\_profile\_encrypted\_password](#output\_user\_login\_profile\_encrypted\_password) | The encrypted password for the user. |
| <a name="output_user_login_profile_key_fingerprint"></a> [user\_login\_profile\_key\_fingerprint](#output\_user\_login\_profile\_key\_fingerprint) | The MD5 message digest of the key used to encrypt the password. |
| <a name="output_user_name"></a> [user\_name](#output\_user\_name) | The user name of the user. |
| <a name="output_user_path"></a> [user\_path](#output\_user\_path) | The path to the user. |
| <a name="output_user_unique_id"></a> [user\_unique\_id](#output\_user\_unique\_id) | The unique ID assigned by AWS. |
<!-- END_TF_DOCS -->