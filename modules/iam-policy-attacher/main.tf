resource "aws_iam_policy_attachment" "this" {
  for_each   = local.iam_policy_attachment_to_create
  name       = each.value["name"]
  users      = each.value["users"]
  roles      = each.value["roles"]
  groups     = each.value["groups"]
  policy_arn = each.value["policy_arn"]
}
