module "main_module" {
  source                      = "../../../modules/iam-system-user"
  is_enabled                  = var.is_enabled
  aws_region                  = var.aws_region
  iam_user_credentials_config = var.iam_user_credentials_config
  iam_user_config             = var.iam_user_config
  iam_user_permissions_config = var.iam_user_permissions_config
}
