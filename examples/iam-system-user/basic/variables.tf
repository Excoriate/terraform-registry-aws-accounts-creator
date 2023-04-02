variable "is_enabled" {
  description = "Enable or disable the module"
  type        = bool
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "iam_user_config" {
  type = list(object({
    name = string
    path = optional(string, "/")
  }))
  description = <<EOF
This configuration will be used to create the IAM user, that's intended for system/programmatic access.
The following attributes are supported:
- name: The name of the user to create. It can't be ommited.
- path: Path in which to create the user. If it does not already exist, it will be created. If omitted, the user will be created at the root path.
For more information about this specific configuration, please refer to the following link: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user
EOF
}

variable "iam_user_permissions_config" {
  type = list(object({
    name                   = string
    permissions_boundary   = optional(string, null)
    policies_arn_to_attach = optional(list(string), [])
  }))
  description = <<EOF
This configuration works along with the iam_user_config to create the IAM user, that's intended for system/programmatic access.
Specifically, it enables the user to have certain permissions to perform certain actions, by attaching policies to the user in
'json' format (i.e. the policy document). The following attributes are supported:
- name: The name of the user to create. It can't be ommited. It's used to identify the user to which the permissions will be attached.
- permissions_boundary: The ARN of the policy that is used to set the permissions boundary for the user.
- policies_arn_to_attach: A list of ARNs of policies to attach to the user.
EOF
  default     = null
}

variable "iam_user_credentials_config" {
  type = list(object({
    name    = string
    enabled = optional(bool, true)
  }))
  description = <<EOF
This configuration works along with the iam_user_config to create the IAM user, that's intended for system/programmatic access. It enables
the user to have access keys to perform certain actions, by creating access keys for the user. The following attributes are supported:
- name: The name of the user to create. It can't be ommited. It's used to identify the user to which the access keys will be created.
- enabled: Whether to create access keys for the user. If set to false, the access keys will not be created.
EOF
  default     = null
}
