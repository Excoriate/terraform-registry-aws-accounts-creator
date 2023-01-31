resource "aws_iam_group_policy" "this" {
  for_each = local.group_permissions_to_create
  name     = each.value["name"]
  group    = each.value["group"]
  policy   = each.value["policy"]
}
