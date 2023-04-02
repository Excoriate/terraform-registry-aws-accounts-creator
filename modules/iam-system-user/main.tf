resource "aws_iam_user" "this" {
  for_each             = local.iam_user_cfg_map
  name                 = lookup(each.value, "name")
  path                 = lookup(each.value, "path", null)
  force_destroy        = true
  tags                 = var.tags
  permissions_boundary = lookup(local.iam_user_permissions_cfg_map, each.key, null) // IAM User Permissions Boundary
}
