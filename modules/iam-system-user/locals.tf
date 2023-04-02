locals {
  aws_region_to_deploy = var.aws_region

  is_iam_user_enabled        = !var.is_enabled ? false : var.iam_user_config == null ? false : length(var.iam_user_config) > 0
  is_iam_permissions_enabled = !local.is_iam_user_enabled ? false : var.iam_user_permissions_config == null ? false : length(var.iam_user_permissions_config) > 0

  /*
    * -------------------------------------------------------
    * IAM user configuration
    * -------------------------------------------------------
  */

  iam_user_cfg_normalised = !local.is_iam_user_enabled ? [] : [
    for usr in var.iam_user_config : {
      name          = trimspace(usr["name"])
      force_destroy = lookup(usr, "force_destroy", false)
      path          = contains(regexall("/", trimspace(usr["path"])), "/") ? trimspace(usr["path"]) : "/" + trimspace(usr["path"])
    }
  ]

  iam_user_cfg_map = !local.is_iam_user_enabled ? {} : {
    for usr in local.iam_user_cfg_normalised : usr["name"] => usr
  }

  /*
    * -------------------------------------------------------
    * IAM permissions configuration
    * -------------------------------------------------------
  */
  iam_user_permissions_cfg_normalised = !local.is_iam_permissions_enabled ? [] : [
    for p in var.iam_user_permissions_config : {
      name                 = trimspace(p["name"])
      policy_name          = format("%s-in-policy", trimspace(p["name"]))
      permissions_boundary = p["permissions_boundary"] == null ? null : trimspace(p["permissions_boundary"])
      inline_policy        = p["policy_inline_json"] == null ? null : trimspace(p["policy_inline_json"])
      attached_policy_arn  = [for pol in p["policy_arns_to_attach"] : trimspace(pol)]
    }
  ]

  iam_user_permissions_cfg_map = !local.is_iam_permissions_enabled ? {} : {
    for p in local.iam_user_permissions_cfg_normalised : p["name"] => p
  }
}
