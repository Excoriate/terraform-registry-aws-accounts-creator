variable "is_enabled" {
  description = "Enable or disable the module"
  type        = bool
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

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
