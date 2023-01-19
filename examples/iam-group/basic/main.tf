module "main_module" {
  source     = "../../../modules/iam-group"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  groups_config = var.groups_config
}
