variable "is_enabled" {
  description = "Enable or disable the module"
  type        = bool
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "iam_policy_config" {
  type = list(object({
    name               = string
    policy_document_id = optional(string, null)
    description        = optional(string, "No description given to this IAM policy")
    statements = optional(list(object({
      sid           = string // Required.
      effect        = optional(string, null)
      actions       = optional(list(string), null)
      not_actions   = optional(list(string), null)
      resources     = optional(list(string), null)
      not_resources = optional(list(string), null)
      // Optional block during the formation of the IAM policy.
      not_principals = optional(list(object({
        type        = string
        identifiers = list(string)
      })), null)
      // Optional block during the formation of the IAM policy.
      principals = optional(list(object({
        type        = string
        identifiers = list(string)
      })), null)
      // Optional block during the formation of the IAM policy.
      condition = optional(list(object({
        test     = string
        variable = string
        values   = list(string)
      })), null)
    })), null)
    source_policy_documents   = optional(list(string), [])
    override_policy_documents = optional(list(string), [])
  }))
  description = <<EOF
  A list of objects that contains the configuration of the IAM policies to be created.
  Each object in the list represents a single IAM policy. The current supported options are:
  - name: The name of the IAM policy.
  - policy_document_id: The ID of the IAM policy document to be used. If this is not provided, the module will create a new IAM policy document.
  - description: The description of the IAM policy.
If this is not provided, the module will create a new IAM policy document.
  - statements: A list of objects that contains the configuration of the IAM policy statements to be created.
  Each object in the list represents a single IAM policy statement. The current supported options are:
  - sid: The SID of the IAM policy statement.
  - effect: The effect of the IAM policy statement.
  - actions: A list of actions to be allowed or denied by the IAM policy statement.
  - not_actions: A list of actions to be denied by the IAM policy statement.
  - resources: A list of resources to be allowed or denied by the IAM policy statement.
  - not_resources: A list of resources to be denied by the IAM policy statement.
  - not_principals: A list of objects that contains the configuration of the IAM policy statement not principals.
  Each object in the list represents a single IAM policy statement not principal. The current supported options are:
  - type: The type of the IAM policy statement not principal.
  - identifiers: A list of identifiers of the IAM policy statement not principal.
  - principals: A list of objects that contains the configuration of the IAM policy statement principals.
  Each object in the list represents a single IAM policy statement principal. The current supported options are:
  - type: The type of the IAM policy statement principal.
  - identifiers: A list of identifiers of the IAM policy statement principal.
  - condition: A list of objects that contains the configuration of the IAM policy statement condition.
  Each object in the list represents a single IAM policy statement condition. The current supported options are:
  - test: The test of the IAM policy statement condition.
  - variable: The variable of the IAM policy statement condition.
  - values: A list of values of the IAM policy statement condition.
  - source_policy_documents: A list of IDs of the IAM policy documents to be used as source for the IAM policy.
  - override_policy_documents: A list of IDs of the IAM policy documents to be used as override for the IAM policy.
  EOF
  default     = null
}
