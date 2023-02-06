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
output "user_name" {
  value       = module.main_module.user_name
  description = "The user name of the user."
}

output "user_arn" {
  value       = module.main_module.user_arn
  description = "The ARN of the user."
}

output "user_unique_id" {
  value       = module.main_module.user_unique_id
  description = "The unique ID assigned by AWS."
}

output "user_path" {
  value       = module.main_module.user_path
  description = "The path to the user."
}

output "user_login_profile_encrypted_password" {
  value       = module.main_module.user_login_profile_encrypted_password
  description = "The encrypted password for the user."
}

output "user_login_profile_key_fingerprint" {
  value       = module.main_module.user_login_profile_key_fingerprint
  description = "The MD5 message digest of the key used to encrypt the password."
}

output "pgp_key" {
  value       = module.main_module.pgp_key
  description = "The PGP key to use to encrypt the password."
}

output "passwords"{
  value       = module.main_module.passwords
  description = "The passwords for the user."
}
