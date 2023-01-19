locals {
  is_enabled           = !var.is_enabled ? false : var.groups_config == null ? false : length(var.groups_config) > 0 ? true : false
  aws_region_to_deploy = var.aws_region

  /*
    * Since the 'path' is optional, and require some validations, a normalization object is created.
  */
  groups_normalised = local.is_enabled ? [
    for group in var.groups_config : {
      name = group.name
      path = try(group["path"], "/")
      path = group["path"] == "" ? null : trimspace(length(regexall("^/", group["path"])) == 0 ? "/${group["path"]}" : group["path"])
      path = group["path"] == "" ? null : trimspace(length(regexall("/$", group["path"])) == 0 ? "${group["path"]}/" : group["path"])
    }
  ] : []

  groups_to_create = length(local.groups_normalised) > 0 ? {
    for k, v in local.groups_normalised : v["name"] => {
      name = v["name"]
      path = v["path"]
    }
  } : {}
}
