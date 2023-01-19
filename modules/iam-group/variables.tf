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

variable "groups_config" {
  type = list(object({
    name = string
    path = optional(string, "")
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
