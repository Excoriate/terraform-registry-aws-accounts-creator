variable "is_enabled" {
  type        = bool
  description = <<EOF
  Whether this module will be created or not. It is useful, for stack-composite
modules that conditionally includes resources provided by this module..
EOF
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy the resources"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}

/*
-------------------------------------
Custom input variables
-------------------------------------
*/
variable "iam_user_config" {
  type = list(object({
    name          = string
    path          = optional(string, "/")
    force_destroy = optional(bool, false)
  }))
  description = <<EOF
This configuration will be used to create the IAM user, that's intended for system/programmatic access.
The following attributes are supported:
- name: The name of the user to create. It can't be ommited.
- force_destroy: When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed.
- path: Path in which to create the user. If it does not already exist, it will be created. If omitted, the user will be created at the root path.
For more information about this specific configuration, please refer to the following link: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user
EOF
}

variable "iam_user_permissions_config" {
  type = list(object({
    name                  = string
    permissions_boundary  = optional(string, null)
    policy_inline_json    = optional(string, null)
    policy_arns_to_attach = optional(list(string), [])
  }))
  description = <<EOF
This configuration works along with the iam_user_config to create the IAM user, that's intended for system/programmatic access.
Specifically, it enables the user to have certain permissions to perform certain actions, by attaching policies to the user in
'json' format (i.e. the policy document). The following attributes are supported:
- name: The name of the user to create. It can't be ommited. It's used to identify the user to which the permissions will be attached.
- permissions_boundary: The ARN of the policy that is used to set the permissions boundary for the user.
- policy_inline_json: The policy document in 'json' format. It can be used to create a policy in-line. Ensure it's set
and the policy_arns_to_attach is set to an empty list, if you want to create a policy in-line. Both types of policies can't be
attached to the same user.
For more information, please refer to how the policy document is defined in the following link: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy
EOF
  default     = null
}

variable "iam_user_credentials_config" {
  type = list(object({
    name    = string
    enabled = optional(bool, true)
    pgp_key = optional(string, null)
    status  = optional(string, "Active")
  }))
  description = <<EOF
This configuration works along with the iam_user_config to create the IAM user, that's intended for system/programmatic access. It enables
the user to have access keys to perform certain actions, by creating access keys for the user. The following attributes are supported:
- name: The name of the user to create. It can't be ommited. It's used to identify the user to which the access keys will be created.
- enabled: Whether to create access keys for the user. If set to false, the access keys will not be created.
- pgp_key: The PGP key to encrypt the access keys. If it's not set, the access keys will not be encrypted.
- status: The status of the access keys. Can be either Active or Inactive.
EOF
  default     = null
}
