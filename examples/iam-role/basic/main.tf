module "main_module" {
  source     = "../../../modules/iam-role"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  iam_role_config = var.iam_role_config
}
