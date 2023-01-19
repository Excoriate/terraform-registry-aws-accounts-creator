resource "aws_iam_group" "this" {
  for_each = local.groups_to_create
  name     = each.value["name"]
  path     = each.value["path"]
}
