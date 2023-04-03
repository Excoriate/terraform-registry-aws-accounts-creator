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

output "iam_user_policy_inline_id" {
  value       = [for p in aws_iam_user_policy.inline : p.id]
  description = "The list of inline policy IDs."
}

output "iam_user_policy_inline_name" {
  value       = [for p in aws_iam_user_policy.inline : p.name]
  description = "The list of inline policy names."
}

output "iam_user_policy_inline_policy" {
  value       = [for p in aws_iam_user_policy.inline : p.policy]
  description = "The list of inline policy documents."
}

output "iam_user_policy_attached_id" {
  value       = [for p in aws_iam_user_policy_attachment.attached_policy : p.id]
  description = "The list of attached policy IDs."
}

output "iam_user_policy_attached_policy_arn" {
  value       = [for p in aws_iam_user_policy_attachment.attached_policy : p.policy_arn]
  description = "The list of attached policy ARNs."
}

output "iam_user_key_id" {
  value       = [for k in aws_iam_access_key.this : k.id]
  description = "The list of access key IDs."
  sensitive   = true
}

output "iam_user_key_status" {
  value       = [for k in aws_iam_access_key.this : k.status]
  description = "The list of access key statuses."
}

output "iam_user_key_secret" {
  value       = [for k in aws_iam_access_key.this : k.secret]
  description = "The list of access key secrets."
  sensitive   = true
}
