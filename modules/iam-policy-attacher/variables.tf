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
variable "config" {
  type = list(object({
    name       = string
    users      = optional(list(string))
    role       = string
    groups     = optional(list(string))
    policy_arn = string
  }))
  description = <<EOF
   The configuration for the IAM policy attacher. The current configuration allowed are:
  - name - The name of the IAM policy attacher
  - users - The list of IAM users to attach the policy to
  - role - The IAM role to attach the policy to
  - groups - The list of IAM groups to attach the policy to
  - policy_arn - The ARN of the IAM policy to attach
  EOF
  default     = null
}
