locals {
  is_enabled           = !var.is_enabled ? false : var.users_config == null ? false : length(var.users_config) > 0 ? true : false
  aws_region_to_deploy = var.aws_region

  /*
    * -------------------------------------------------------
    * User Creation.
    * -------------------------------------------------------
  */
  users_normalised = local.is_enabled ? [
    for user in var.users_config : {
      name                 = trimspace(user.email)
      path                 = user["path"] == "" ? null : trimspace(length(regexall("^/", user["path"])) == 0 ? "/${user["path"]}" : user["path"])
      path                 = user["path"] == "" ? null : trimspace(length(regexall("/$", user["path"])) == 0 ? "${user["path"]}/" : user["path"])
      force_destroy        = user["force_destroy"]
      permissions_boundary = var.global_permission_boundary == null ? user["permissions_boundary"] : var.global_permission_boundary
    }
  ] : []

  users_to_create = length(local.users_normalised) > 0 ? {
    for k, v in local.users_normalised : v["name"] => {
      name                 = v["name"]
      path                 = v["path"]
      force_destroy        = v["force_destroy"]
      permissions_boundary = v["permissions_boundary"]
    }
  } : {}


  /*
    * -------------------------------------------------------
    * Login profile
    * -------------------------------------------------------
  */
  users_login_profile_normalised = local.is_enabled ? [
    for user in var.users_config : {
      name                    = trimspace(user.email)
      pgp_key                 = trimspace(var.pgp_key)
      password_reset_required = var.global_password_reset_required == null ? user["password_reset_required"] : var.global_password_reset_required
      password_length         = var.global_password_length == null ? user["password_length"] : var.global_password_length
    }
  ] : []

  users_login_profile_to_create = length(local.users_login_profile_normalised) > 0 ? {
    for k, v in local.users_login_profile_normalised : v["name"] => {
      name                    = v["name"]
      pgp_key                 = v["pgp_key"]
      password_reset_required = v["password_reset_required"]
      password_length         = v["password_length"]
    }
  } : {}

  /*
    * -------------------------------------------------------
    * Groups membership
    * -------------------------------------------------------
  */
  global_groups_normalised = var.global_groups == null ? [] : var.global_groups
  users_groups_normalised = local.is_enabled ? [
    for user in var.users_config : {
      name   = trimspace(user.email)
      groups = length(local.global_groups_normalised) == 0 ? user["groups"] : local.global_groups_normalised
    }
  ] : []

  users_groups_to_create = length(local.users_groups_normalised) > 0 ? {
    for k, v in local.users_groups_normalised : v["name"] => {
      name   = v["name"]
      groups = v["groups"]
    }
  } : {}

  /*
    * -------------------------------------------------------
    * Encrypted password
    * -------------------------------------------------------
  */

  encrypted_password               = join("", [for login in aws_iam_user_login_profile.this : login.encrypted_password])
  pgp_key_is_keybase               = length(regexall("keybase:", var.pgp_key)) > 0 ? true : false
  keybase_password_pgp_message     = local.pgp_key_is_keybase ? templatefile("${path.module}/templates/keybase_password_pgp_message.txt", { encrypted_password = local.encrypted_password }) : ""
  keybase_password_decrypt_command = local.pgp_key_is_keybase ? templatefile("${path.module}/templates/keybase_password_decrypt_command.sh", { encrypted_password = local.encrypted_password }) : ""
}
