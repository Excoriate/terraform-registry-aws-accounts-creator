module "target" {
  source         = "../../../../../modules/default"
  aws_org_config = var.aws_org_config
  aws_region     = var.aws_region
  is_enabled     = var.is_enabled
}

provider "aws" {
  region = var.aws_region
}

# ----------------------------------
# Emulate input variables required by
# the target module
# ----------------------------------
variable "is_enabled" {
  type = bool
}

variable "aws_region" {
  type = string
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

# ----------------------------------
# Emulate output variables provided by
# the target module
# ----------------------------------
output "is_enabled" {
  value = var.is_enabled
}

output "aws_region_for_deploy_this" {
  value = module.target.aws_region_for_deploy_this
}

output "aws_org_principals" {
  value = module.target.aws_org_principals
}

output "aws_accounts_to_create" {
  value = module.target.aws_accounts_to_create
}

output "aws_org_units" {
  value = module.target.aws_org_units
}
