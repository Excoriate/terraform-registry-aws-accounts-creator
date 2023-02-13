output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "aws_region_for_deploy_this" {
  value       = local.aws_region_to_deploy
  description = "The AWS region where the module is deployed."
}

output "tags_set" {
  value       = var.tags
  description = "The tags set for the module."
}

/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "iam_role_id" {
  value       = [for role in aws_iam_role.this : role.id]
  description = "The ID of the IAM role."
}

output "iam_role_arn" {
  value       = [for role in aws_iam_role.this : role.arn]
  description = "The ARN of the IAM role."
}

output "iam_role_name" {
  value       = [for role in aws_iam_role.this : role.name]
  description = "The name of the IAM role."
}

output "iam_role_unique_id" {
  value       = [for role in aws_iam_role.this : role.unique_id]
  description = "The stable and unique string identifying the role."
}

output "iam_role_description" {
  value       = [for role in aws_iam_role.this : role.description]
  description = "The description of the IAM role."
}

output "iam_role_force_detach_policies" {
  value       = [for role in aws_iam_role.this : role.force_detach_policies]
  description = "Specifies to force detaching any policies the role has before destroying it."
}

output "iam_role_max_session_duration" {
  value       = [for role in aws_iam_role.this : role.max_session_duration]
  description = "The maximum session duration (in seconds) that you want to set for the specified role."
}

output "iam_role_path" {
  value       = [for role in aws_iam_role.this : role.path]
  description = "The path to the role."
}

output "iam_role_permissions_boundary" {
  value       = [for role in aws_iam_role.this : role.permissions_boundary]
  description = "The ARN of the policy that is used to set the permissions boundary for the role."
}
