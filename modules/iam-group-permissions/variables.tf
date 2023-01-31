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

variable "group_permissions_config" {
  type = list(object({
    group_name = string
    policy     = string
  }))
  default     = null
  description = <<EOF
  A list of objects that contains the group name and the policy to attach to the group.
  EOF
}
