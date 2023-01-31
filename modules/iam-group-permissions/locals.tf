locals {
  is_enabled           = !var.is_enabled ? false : var.group_permissions_config == null ? false : length(var.group_permissions_config) > 0 ? true : false
  aws_region_to_deploy = var.aws_region

  /*
    * Configuration of an IAM group policy attachment, and the policy itself.
  */
  group_permissions_normalised = local.is_enabled ? [
    for permission in var.group_permissions_config : {
      name   = trimspace(permission.group_name)
      policy = permission.policy
    }
  ] : []

  group_permissions_to_create = local.is_enabled ? {
    for k, v in local.group_permissions_normalised : v["name"] => {
      group  = v["name"]
      name   = format("policy_%s_%s", v["name"], replace(local.aws_region_to_deploy, "-", "_"))
      policy = v["policy"]
    }
  } : {}
}
