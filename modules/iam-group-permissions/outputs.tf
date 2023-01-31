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
output "group_policy_id" {
  value       = join("", [for p in aws_iam_group_policy.this : p.id])
  description = "The ID of the group policy."
}

output "group_policy_name" {
  value       = join("", [for p in aws_iam_group_policy.this : p.name])
  description = "The name of the group policy."
}

output "group_policy_policy" {
  value       = join("", [for p in aws_iam_group_policy.this : p.policy])
  description = "The policy document."
}

output "group_policy_group" {
  value       = join("", [for p in aws_iam_group_policy.this : p.group])
  description = "The group the policy is attached to."
}
