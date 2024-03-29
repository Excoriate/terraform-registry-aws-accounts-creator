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
output "iam_user_id" {
  value       = module.main_module.iam_user_id
  description = "The ID of the IAM user."
}

output "iam_user_arn" {
  value       = module.main_module.iam_user_arn
  description = "The ARN of the IAM user."
}

output "iam_user_name" {
  value       = module.main_module.iam_user_name
  description = "The name of the IAM user."
}

output "iam_user_path" {
  value       = module.main_module.iam_user_path
  description = "The path of the IAM user."
}

output "iam_user_permissions_boundary" {
  value       = module.main_module.iam_user_permissions_boundary
  description = "The ARN of the policy that is used to set the permissions boundary for the user."
}

output "iam_user_policy_inline_id" {
  value       = module.main_module.iam_user_policy_inline_id
  description = "The list of inline policy IDs."
}

output "iam_user_policy_inline_name" {
  value       = module.main_module.iam_user_policy_inline_name
  description = "The list of inline policy names."
}

output "iam_user_policy_inline_policy" {
  value       = module.main_module.iam_user_policy_inline_policy
  description = "The list of inline policy documents."
}

output "iam_user_policy_attached_id" {
  value       = module.main_module.iam_user_policy_attached_id
  description = "The list of attached policy IDs."
}

output "iam_user_policy_attached_policy_arn" {
  value       = module.main_module.iam_user_policy_attached_policy_arn
  description = "The list of attached policy ARNs."
}

output "iam_user_key_id" {
  value       = module.main_module.iam_user_key_id
  description = "The list of access key IDs."
  sensitive   = true
}

output "iam_user_key_status" {
  value       = module.main_module.iam_user_key_status
  description = "The list of access key statuses."
}

output "iam_user_key_secret" {
  value       = module.main_module.iam_user_key_secret
  description = "The list of access key secrets."
  sensitive   = true
}
