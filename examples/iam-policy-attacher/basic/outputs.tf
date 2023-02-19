output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "aws_region_for_deploy_this" {
  value       = module.main_module.aws_region_for_deploy_this
  description = "The AWS region where the module is deployed."
}

output "tags_set" {
  value       = module.main_module.tags_set
  description = "The tags set for the module."
}

/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "iam_policy_attachment_name" {
  value       = module.main_module.iam_policy_attachment_name
  description = "The name of the IAM policy attachment."
}

output "iam_policy_attachment_id" {
  value       = module.main_module.iam_policy_attachment_id
  description = "The ID of the IAM policy attachment."
}
