output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "aws_region_for_deploy_this" {
  value       = local.aws_region_to_deploy
  description = "The AWS region where the module is deployed."
}

output "aws_org_principals" {
  value       = local.aws_org_principals
  description = "List of AWS Organization principals"
}

output "aws_accounts_to_create" {
  value       = local.aws_accounts
  description = "List of AWS accounts to create"
}

output "aws_org_units" {
  value       = local.aws_org_units
  description = "List of AWS Organization units"
}
