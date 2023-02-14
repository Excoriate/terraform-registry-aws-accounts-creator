module "main_module" {
  source     = "../../../modules/iam-policy"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  iam_policy_config = var.iam_policy_config
}
