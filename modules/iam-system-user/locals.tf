locals {
  aws_region_to_deploy = var.aws_region

  /*
    * -------------------------------------------------------
    * Feature flags
    * -------------------------------------------------------
  */
  is_iam_user_enabled        = !var.is_enabled ? false : var.iam_user_config == null ? false : length(var.iam_user_config) > 0
  is_iam_permissions_enabled = !local.is_iam_user_enabled ? false : var.iam_user_permissions_config == null ? false : length(var.iam_user_permissions_config) > 0

  iam_user_cfg_normalised = !local.is_iam_user_enabled ? [] : [
    for usr in var.iam_user_config : {
      name = trimspace(usr["name"])
      path = contains(regexall("/", trimspace(usr["path"])), "/") ? trimspace(usr["path"]) : "/" + trimspace(usr["path"])
    }
  ]

  iam_user_cfg_map = !local.is_iam_user_enabled ? {} : {
    for usr in local.iam_user_cfg_normalised : usr["name"] => usr
  }

  iam_user_permissions_cfg_normalised = !local.is_iam_permissions_enabled ? [] : [
    for p in var.iam_user_permissions_config : {
      name                 = trimspace(p["name"])
      permissions_boundary = trimspace(p["permissions_boundary"])
      policies             = [for pol in p["policies_arn_to_attach"] : trimspace(pol)]
    }
  ]

  iam_user_permissions_cfg_map = !local.is_iam_permissions_enabled ? {} : {
    for p in local.iam_user_permissions_cfg_normalised : p["name"] => p
  }
}
