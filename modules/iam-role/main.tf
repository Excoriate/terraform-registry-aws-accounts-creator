resource "aws_iam_role" "this" {
  for_each             = local.iam_role_config_to_create
  name                 = each.value["name"]
  assume_role_policy   = join("", [for p in data.aws_iam_policy_document.assume_role_aggregated : p.json])
  description          = each.value["description"]
  max_session_duration = each.value["max_session_duration"]
  permissions_boundary = each.value["permissions_boundary"]
  path                 = each.value["path"]
  tags                 = var.tags
}

resource "aws_iam_role_policy_attachment" "default_iam_policy" {
  for_each   = { for k, v in data.aws_iam_policy_document.default : k => v if v != null }
  role       = aws_iam_role.this[each.key].name
  policy_arn = each.value
}

resource "aws_iam_role_policy_attachment" "iam_policy_documents" {
  for_each   = { for k, v in data.aws_iam_policy_document.extra_policies : k => v if v != null }
  role       = aws_iam_role.this[each.key].name
  policy_arn = each.value
}
