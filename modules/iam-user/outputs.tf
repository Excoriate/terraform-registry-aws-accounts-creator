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
output "user_name" {
  value       = [for user in aws_iam_user.this : user.name]
  description = "The user name of the user."
}

output "user_arn" {
  value       = [for user in aws_iam_user.this : user.arn]
  description = "The ARN of the user."
}

output "user_unique_id" {
  value       = [for user in aws_iam_user.this : user.unique_id]
  description = "The unique ID assigned by AWS."
}

output "user_path" {
  value       = [for user in aws_iam_user.this : user.path]
  description = "The path to the user."
}

output "user_login_profile_encrypted_password" {
  value       = [for user in aws_iam_user_login_profile.this : user.encrypted_password]
  description = "The encrypted password for the user."
}

output "user_login_profile_key_fingerprint" {
  value       = [for user in aws_iam_user_login_profile.this : user.key_fingerprint]
  description = "The MD5 message digest of the key used to encrypt the password."
}

output "pgp_key" {
  value       = var.pgp_key
  description = "The PGP key to use to encrypt the password."
}

output "passwords" {
  value       = local.passwords
  description = "The passwords for the user."
}
