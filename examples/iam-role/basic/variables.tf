variable "is_enabled" {
  description = "Enable or disable the module"
  type        = bool
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "iam_role_config" {
  type = list(object({
    name                      = string
    path                      = optional(string, "/")
    description               = optional(string, "No description given to this IAM Role")
    permissions_boundary      = optional(string, null)
    max_session_duration      = optional(number, 3600)
    iam_policy_documents_json = optional(list(string), [])
    default_iam_policy_json   = optional(string, null)
    assume_role_config = object({
      principals = optional(list(object({
        type        = optional(string, "Service")
        identifiers = list(string)
      })), [])
      actions = optional(list(string), [])
      conditions = optional(list(object({
        test     = string
        variable = string
        values   = list(string)
      })), [])
    })
  }))
  description = <<EOF
  A list of objects that contains the configuration for the IAM Role to be created.
  Each object in the list represents a single IAM Role. The following attributes are supported:
- name: Name of the IAM Role to be created.
- path: Path of the IAM Role to be created.
- description: Description of the IAM Role to be created.
- permissions_boundary: The ARN of the policy that is used to set the permissions boundary for the IAM Role.
- max_session_duration: The maximum session duration (in seconds) that you want to set for the specified role.
- iam_policy_documents_json: A list of IAM Policy documents in JSON format.
- assume_role_config: A map of objects that contains the configuration for the IAM Role to be created.
  Each object in the list represents a single IAM Role. The following attributes are supported:
  - principals: A map of lists that contains the AWS principals that are allowed to assume the IAM Role.
  - actions: A list of strings that contains the AWS actions that are allowed to assume the IAM Role.
  - conditions: A list of objects that contains the conditions that are allowed to assume the IAM Role.
    Each object in the list represents a single condition. The following attributes are supported:
    - test: The test that is applied to the condition.
    - variable: The variable that is used in the condition.
    - values: A list of strings that contains the values that are used in the condition.
  EOF
  default     = null
}
