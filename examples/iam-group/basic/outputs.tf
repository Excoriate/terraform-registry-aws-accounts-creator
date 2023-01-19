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
output "groups_created" {
  value       = module.main_module.groups_created
  description = "List of groups that were passed to this module, and created in AWS."
}

output "groups_created_count" {
  value       = module.main_module.groups_created_count
  description = "Number of groups that were passed to this module, and created in AWS."
}

output "groups_created_ids" {
  value       = module.main_module.groups_created_ids
  description = "List of IDs of groups that were passed to this module, and created in AWS."
}

output "groups_created_names" {
  value       = module.main_module.groups_created_names
  description = "List of names of groups that were passed to this module, and created in AWS."
}

output "groups_created_arns" {
  value       = module.main_module.groups_created_arns
  description = "List of ARNs of groups that were passed to this module, and created in AWS."
}
