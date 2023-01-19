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
variable "backend_config" {
  type = list(object({
    name                    = string
    enable_s3_backend       = bool
    enable_dynamodb_backend = optional(bool, false)
  }))
  description = <<EOF
  A list of objects that define a set of backend components to enable. The following components are available:
  - enable_s3_backend: Enable S3 backend
  - enable_dynamodb_backend: Enable DynamoDB backend
E.g:
[
  {
    name = "backend1"
    enable_s3_backend = true
    enable_dynamodb_backend = true
  }
]
EOF
  default     = null
}

variable "backend_optionals" {
  type = object({
    enable_logging                = optional(bool, false)
    enable_versioning             = optional(bool, false)
    enable_server_side_encryption = optional(bool, false)
    force_lower_case              = optional(bool, false)
  })
  description = <<EOF
  An object of backend configuration. The following configuration are available:
  - enable_logging: Enable logging for the backend
  - enable_versioning: Enable versioning for the backend
  - force_lower_case: Force all keys to be lower case
  - enable_server_side_encryption: Enable server side encryption for the backend
E.g:
  {
    enable_logging = true
    enable_versioning = true
    force_lower_case = true
    enable_server_side_encryption = true
  }
EOF
  default = {
    enable_logging                = false
    enable_versioning             = false
    force_lower_case              = false
    enable_server_side_encryption = false
  }
}

variable "dynamodb_optional_config" {
  type = object({
    read_capacity                 = number
    write_capacity                = number
    enable_point_in_time_recovery = optional(bool, false)
    billing_mode                  = optional(string, "PROVISIONED")
  })
  default = {
    read_capacity                 = 1
    write_capacity                = 1
    enable_point_in_time_recovery = false
    billing_mode                  = "PROVISIONED"
  }
  description = <<EOF
  A map of DynamoDB configuration. The following attributes are available:
  - read_capacity: The maximum number of strongly consistent reads consumed per second before DynamoDB returns a ThrottlingException.
  - write_capacity: The maximum number of writes consumed per second before DynamoDB returns a ThrottlingException.
  - enable_point_in_time_recovery: Enable Point-in-time recovery for DynamoDB tables.
  - billing_mode: The billing mode of the table. Valid values are PROVISIONED, PAY_PER_REQUEST. Defaults to PROVISIONED.
E.g:
{
  read_capacity = 5 # should be null or not set if the billing_mode is PAY_PER_REQUEST
  write_capacity = 5 # should be null or not set if the billing_mode is PAY_PER_REQUEST
  enable_point_in_time_recovery = true
  billing_mode = "PROVISIONED"
EOF
}
