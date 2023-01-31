resource "aws_iam_user" "this" {
  for_each = local.users_to_create

  name                 = each.value["name"]
  path                 = each.value["path"]
  permissions_boundary = each.value["permissions_boundary"]
  force_destroy        = each.value["force_destroy"]
  tags                 = var.tags
}

resource "aws_iam_user_login_profile" "this" {
  for_each = local.users_login_profile_to_create

  user                    = join("", [for user in aws_iam_user.this : user.name if user != null])
  pgp_key                 = each.value["pgp_key"]
  password_length         = each.value["password_length"]
  password_reset_required = each.value["password_reset_required"]

  depends_on = [aws_iam_user.this]

  lifecycle {
    ignore_changes = [password_reset_required]
  }
}

resource "aws_iam_user_group_membership" "this" {
  for_each   = local.users_groups_to_create
  user       = join("", [for user in aws_iam_user.this : user.name if user != null])
  groups     = each.value["groups"]
  depends_on = [aws_iam_user.this]
}
