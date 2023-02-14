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
output "iam_policy_arn" {
  value       = module.main_module.iam_policy_arn
  description = "The ARN of the IAM policy."
}

output "iam_policy_id" {
  value       = module.main_module.iam_policy_id
  description = "The ID of the IAM policy."
}

output "iam_policy_name" {
  value       = module.main_module.iam_policy_name
  description = "The name of the IAM policy."
}

output "iam_policy_description" {
  value       = module.main_module.iam_policy_description
  description = "The description of the IAM policy."
}

output "iam_policy_path" {
  value       = module.main_module.iam_policy_path
  description = "The path of the IAM policy."
}

output "iam_policy_policy" {
  value       = module.main_module.iam_policy_policy
  description = "The policy of the IAM policy."
}

output "iam_policy_policy_id" {
  value       = module.main_module.iam_policy_policy_id
  description = "The policy ID of the IAM policy."
}
