locals {
  aws_region_to_deploy = var.aws_region

  /*
    * -------------------------------------------------------
    * IAM Role feature flags, and other options.
    * -------------------------------------------------------
  */
  is_iam_role_enabled = !var.is_enabled ? false : var.iam_role_config == null ? false : length(var.iam_role_config) == 0 ? false : true

  iam_role_config_normalised = !local.is_iam_role_enabled ? [] : [
    for role in var.iam_role_config : {
      // If the name exceeds the maximum length, then truncate it.
      name                      = length(trimspace(role.name)) > 64 ? substr(role.name, 0, 64) : trimspace(role.name)
      description               = role["description"]
      path                      = role["path"]
      permissions_boundary      = role["permissions_boundary"]
      max_session_duration      = role["max_session_duration"]
      iam_policy_documents_json = role["iam_policy_documents_json"]
      default_iam_policy_json   = role["default_iam_policy_json"]
      principals = role["assume_role_config"] == null ? {} : {
        for key, value in role["assume_role_config"]["principals"] : key => {
          type        = value["type"] == null ? "AWS" : value["type"]
          identifiers = value["identifiers"]
        }
      }
      actions = role["assume_role_config"] == null ? [] : role["assume_role_config"]["actions"] == null ? [] : role["assume_role_config"]["actions"]
      conditions = [
        for condition in role["assume_role_config"] == null ? [] : role["assume_role_config"]["conditions"] == null ? [] : role["assume_role_config"]["conditions"] : {
          test     = condition["test"]
          variable = condition["variable"]
          values   = condition["values"]
        }
      ]
    }
  ]

  iam_role_config_to_create = !local.is_iam_role_enabled ? {} : {
    for role in local.iam_role_config_normalised : role["name"] => {
      name                      = role["name"]
      description               = role["description"]
      path                      = role["path"]
      permissions_boundary      = role["permissions_boundary"]
      max_session_duration      = role["max_session_duration"]
      iam_policy_documents_json = role["iam_policy_documents_json"]
      default_iam_policy_json   = role["default_iam_policy_json"]
      principals                = role["principals"]
      actions                   = role["actions"]
      conditions                = role["conditions"]
    }
  }
}
