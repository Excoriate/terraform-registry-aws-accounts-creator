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
output "iam_policy_attachment_name" {
  value       = [for policy_attachment in aws_iam_policy_attachment.this : policy_attachment.name]
  description = "The name of the IAM policy attachment."
}

output "iam_policy_attachment_id" {
  value       = [for policy_attachment in aws_iam_policy_attachment.this : policy_attachment.id]
  description = "The ID of the IAM policy attachment."
}
