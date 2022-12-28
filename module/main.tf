resource "aws_organizations_organizational_unit" "this" {
  for_each  = local.is_org_units_enabled ? local.aws_org_units : {}
  name      = each.value["name"]
  parent_id = join("", [for root in aws_organizations_organization.this.*.roots : root.id if root != null])

  tags = var.tags
}

resource "aws_organizations_account" "account_without_org_unit" {
  for_each = local.is_org_units_enabled ? {} : local.aws_accounts

  name                       = each.value["name"]
  email                      = each.value["email"]
  close_on_deletion          = each.value["close_on_deletion"]
  iam_user_access_to_billing = each.value["iam_user_access_to_billing"]

  tags = var.tags
}

resource "aws_organizations_account" "account_with_org_unit" {
  for_each = local.is_org_units_enabled ? local.aws_accounts : {}

  name                       = each.value["name"]
  email                      = each.value["email"]
  close_on_deletion          = each.value["close_on_deletion"]
  iam_user_access_to_billing = each.value["iam_user_access_to_billing"]

  parent_id = join("", aws_organizations_organizational_unit.this[each.value["org_unit"]].id)

  tags = var.tags
}


resource "aws_organizations_organization" "this" {
  count                         = length(local.aws_org_principals) > 0 ? 1 : 0
  aws_service_access_principals = local.aws_org_principals
  feature_set                   = var.aws_org_config.feature_set
}
