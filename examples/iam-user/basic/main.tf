module "main_module" {
  source     = "../../../modules/iam-user"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  // User configuration
  pgp_key                        = var.pgp_key
  users_config                   = var.users_config
  global_groups                  = var.global_groups
  global_password_length         = var.global_password_length
  global_password_reset_required = var.global_password_reset_required
  global_permission_boundary     = var.global_permission_boundary
}
