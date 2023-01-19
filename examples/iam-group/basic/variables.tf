variable "is_enabled" {
  description = "Enable or disable the module"
  type        = bool
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "groups_config" {
  type = list(object({
    name = string
    path = optional(string)
  }))
  default     = null
  description = <<EOF
  A list of objects containing the name and path of the groups to be created.
The 'path' attribute is optional. An example of this input variable is:
[
  {
    name = "group1"
    path = "/path1/"
  },
  {
    name = "group2"
    path = "/path2/"
  }
]
For a more detailed documentation, please refer to: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group
  EOF
}
