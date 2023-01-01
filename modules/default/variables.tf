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

variable "aws_org_config" {
  type = object({
    // Main org configuration
    feature_set                   = optional(string, "ALL")
    aws_service_access_principals = optional(list(string), [])
    // Organizational units configuration
    org_units = optional(list(string), [])
    // AWS accounts configuration
    aws_accounts = list(object({
      name                              = string
      email                             = string
      prefix                            = optional(string, "")
      enable_iam_user_access_to_billing = optional(string, "ALLOW")
      remove_from_org_in_deletion       = optional(bool, true)
    }))
  })
}
