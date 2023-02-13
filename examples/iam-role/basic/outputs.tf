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
output "iam_role_id" {
  value       = module.main_module.iam_role_id
  description = "The ID of the IAM role."
}

output "iam_role_arn" {
  value       = module.main_module.iam_role_arn
  description = "The ARN of the IAM role."
}

output "iam_role_name" {
  value       = module.main_module.iam_role_name
  description = "The name of the IAM role."
}

output "iam_role_unique_id" {
  value       = module.main_module.iam_role_unique_id
  description = "The stable and unique string identifying the role."
}

output "iam_role_description" {
  value       = module.main_module.iam_role_description
  description = "The description of the IAM role."
}

output "iam_role_force_detach_policies" {
  value       = module.main_module.iam_role_force_detach_policies
  description = "Specifies to force detaching any policies the role has before destroying it."
}

output "iam_role_max_session_duration" {
  value       = module.main_module.iam_role_max_session_duration
  description = "The maximum session duration (in seconds) that you want to set for the specified role."
}

output "iam_role_path" {
  value       = module.main_module.iam_role_path
  description = "The path to the role."
}

output "iam_role_permissions_boundary" {
  value       = module.main_module.iam_role_permissions_boundary
  description = "The ARN of the policy that is used to set the permissions boundary for the role."
}
