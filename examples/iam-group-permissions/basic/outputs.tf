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
output "group_policy_id" {
  value       = module.main_module.group_policy_id
  description = "The ID of the group policy."
}

output "group_policy_name" {
  value       = module.main_module.group_policy_name
  description = "The name of the group policy."
}

output "group_policy_policy" {
  value       = module.main_module.group_policy_policy
  description = "The policy document."
}

output "group_policy_group" {
  value       = module.main_module.group_policy_group
  description = "The group the policy is attached to."
}
