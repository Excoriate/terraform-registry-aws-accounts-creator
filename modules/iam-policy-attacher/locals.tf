locals {
  aws_region_to_deploy = var.aws_region

  /*
    * -------------------------------------------------------
    * Feature flags
    * -------------------------------------------------------
  */
  is_enabled = !var.is_enabled ? false : var.config != null

  iam_policy_attachment_normalised = !local.is_enabled ? [] : [
    for attachment in var.config : {
      name       = lower(trimspace(attachment["name"]))
      users      = attachment["users"] == null ? null : [for user in attachment["users"] : lower(trimspace(user))]
      groups     = attachment["groups"] == null ? null : [for group in attachment["groups"] : lower(trimspace(group))]
      roles      = [trimspace(attachment["role"])]
      policy_arn = trimspace(attachment["policy_arn"])
    }
  ]

  iam_policy_attachment_to_create = !local.is_enabled ? {} : {
    for a in local.iam_policy_attachment_normalised : a["name"] => {
      name       = a["name"]
      users      = a["users"]
      groups     = a["groups"]
      roles      = a["roles"]
      policy_arn = a["policy_arn"]
    }
  }
}
