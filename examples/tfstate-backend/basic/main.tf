module "main_module" {
  source     = "../../../modules/tfstate-backend"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  backend_config           = var.backend_config
  backend_optionals        = var.backend_optionals
  dynamodb_optional_config = var.dynamodb_optional_config
}
