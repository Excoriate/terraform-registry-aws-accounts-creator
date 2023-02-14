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
output "iam_policy_arn" {
  value       = [for p in aws_iam_policy.this : p.arn]
  description = "The ARN of the IAM policy."
}

output "iam_policy_id" {
  value       = [for p in aws_iam_policy.this : p.id]
  description = "The ID of the IAM policy."
}

output "iam_policy_name" {
  value       = [for p in aws_iam_policy.this : p.name]
  description = "The name of the IAM policy."
}

output "iam_policy_description" {
  value       = [for p in aws_iam_policy.this : p.description]
  description = "The description of the IAM policy."
}

output "iam_policy_path" {
  value       = [for p in aws_iam_policy.this : p.path]
  description = "The path of the IAM policy."
}

output "iam_policy_policy" {
  value       = [for p in aws_iam_policy.this : p.policy]
  description = "The policy of the IAM policy."
}

output "iam_policy_policy_id" {
  value       = [for p in aws_iam_policy.this : p.policy_id]
  description = "The policy ID of the IAM policy."
}
