resource "aws_iam_user" "this" {
  for_each             = local.iam_user_cfg_map
  name                 = lookup(each.value, "name")
  path                 = lookup(each.value, "path", null)
  force_destroy        = lookup(each.value, "force_destroy", false)
  tags                 = var.tags
  permissions_boundary = lookup(local.iam_user_permissions_cfg_map[each.key], "permissions_boundary", null) // IAM User Permissions Boundary
}

resource "aws_iam_user_policy" "inline" {
  for_each = { for k, v in local.iam_user_permissions_cfg_map : k => v if v["inline_policy"] != null && length(v["attached_policy_arn"]) == 0 }
  name     = each.value["policy_name"]
  user     = aws_iam_user.this[each.key].name
  policy   = each.value["inline_policy"]
}

resource "aws_iam_user_policy_attachment" "attached_policy" {
  for_each   = { for k, v in local.iam_user_permissions_cfg_map : k => v if length(v["attached_policy_arn"]) != 0 }
  user       = aws_iam_user.this[each.key].name
  policy_arn = each.value["attached_policy_arn"]
}
