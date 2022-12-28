locals {
  // Default service principals
  default_aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "ec2.amazonaws.com",
    "iam.amazonaws.com",
    "kms.amazonaws.com",
    "rds.amazonaws.com",
    "route53.amazonaws.com",
    "s3.amazonaws.com",
    "sts.amazonaws.com",
    "sso.amazonaws.com",
  ]

  // This one is just to be exposed as an output value, also it's required by an upstream terragrunt stack.
  aws_region_to_deploy = var.aws_region

  // feature flags.
  is_org_units_enabled = !var.is_enabled ? false : length(var.aws_org_config.org_units) > 0 ? true : false

  // Normalization of required objects
  aws_org_principals = !var.is_enabled ? [] : length(var.aws_org_config.aws_service_access_principals) == 0 ? [] : concat(local.default_aws_service_access_principals, var.aws_org_config.aws_service_access_principals)

  // Normalization of AWS accounts passed.
  aws_accounts = !var.is_enabled ? {} : { for k, v in var.aws_org_config.aws_accounts : k => {
    name                       = trimspace(v["prefix"]) == "" ? trimspace(lower(v["name"])) : format("%s-%s", trimspace(lower(v["prefix"])), trimspace(lower(v["name"])))
    email                      = trimspace(v["email"])
    iam_user_access_to_billing = v["enable_iam_user_access_to_billing"]
    close_on_deletion          = !v["remove_from_org_in_deletion"]
  } }

  aws_org_units = !var.is_enabled ? {} : { for k, v in var.aws_org_config.org_units : k => {
    name = trimspace(k)
  } }
}
