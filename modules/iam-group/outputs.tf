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
output "groups_created" {
  value       = local.groups_normalised
  description = "List of groups that were passed to this module, and created in AWS."
}

output "groups_created_count" {
  value       = length(local.groups_normalised)
  description = "Number of groups that were passed to this module, and created in AWS."
}

output "groups_created_ids" {
  value       = join("", [for group in aws_iam_group.this : group.id])
  description = "List of IDs of groups that were passed to this module, and created in AWS."
}

output "groups_created_names" {
  value       = join("", [for group in aws_iam_group.this : group.name])
  description = "List of names of groups that were passed to this module, and created in AWS."
}

output "groups_created_arns" {
  value       = join("", [for group in aws_iam_group.this : group.arn])
  description = "List of ARNs of groups that were passed to this module, and created in AWS."
}
