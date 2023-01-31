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

variable "users_config" {
  type = list(object({
    email                   = string // Will be user as an user-name
    force_destroy           = optional(bool, false)
    path                    = optional(string, "/")
    permissions_boundary    = optional(string, null)
    password_reset_required = optional(bool, true)
    password_length         = optional(number, 24)
    groups                  = optional(list(string), [])
  }))
  default     = null
  description = <<EOF
 A list that defines a set of users that'll be created. These users are actual 'Console/Human' users
  and not service accounts. E.g.: Simple configuration that'll create two users
  users_config = [
    {
      email = "someone@example.com",
      force_destroy: true,
      path: "/devops/"
    },
    {
      email = "someone@example.com",
      force_destroy: true,
      path: "/devops/"
      password_length: 32,
      password_reset_required: false,
      groups: ["devops", "developers"],
    },
  ]
For more details about this resource, please refer to: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user
EOF
}

variable "global_permission_boundary" {
  type        = string
  description = "A global permission boundary that'll be applied to all users"
  default     = null
}

variable "pgp_key" {
  type        = string
  description = <<EOF
  A PGP key that'll be used to encrypt the generated password. This is useful when you want to
  share the generated password with other users. The generated password will be encrypted using
  the provided PGP key. The encrypted password will be stored in the Terraform state file.
  EOF
}

variable "global_password_reset_required" {
  type        = bool
  default     = null
  description = <<EOF
  Whether the generated password should be reset on the first login. This is useful when you want
  to force the user to change the password on the first login. This can be set either
individually for each user or globally for all users. If this variable is set, it'll take precedence
over the value set in the 'password_reset_required' variable.
  EOF
}

variable "global_groups" {
  type        = list(string)
  default     = null
  description = <<EOF
  A list of groups that'll be added to all users. This can be set either individually for each user
or globally for all users. If this variable is set, it'll take precedence over the value set in the
'groups' attribute of the var.users_config variable.
  EOF
}

variable "global_password_length" {
  type        = number
  default     = null
  description = <<EOF
  The length of the generated password. This can be set either individually for each user or
globally for all users. If this variable is set, it'll take precedence over the value set in the
'password_length' attribute of the var.users_config variable.
  EOF
}
