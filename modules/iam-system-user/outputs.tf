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
output "iam_user_id" {
  value       = [for user in aws_iam_user.this : user.id]
  description = "The ID of the IAM user."
}

output "iam_user_arn" {
  value       = [for user in aws_iam_user.this : user.arn]
  description = "The ARN of the IAM user."
}

output "iam_user_name" {
  value       = [for user in aws_iam_user.this : user.name]
  description = "The name of the IAM user."
}

output "iam_user_path" {
  value       = [for user in aws_iam_user.this : user.path]
  description = "The path of the IAM user."
}

output "iam_user_permissions_boundary" {
  value       = [for user in aws_iam_user.this : user.permissions_boundary]
  description = "The ARN of the policy that is used to set the permissions boundary for the user."
}
