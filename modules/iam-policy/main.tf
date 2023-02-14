resource "aws_iam_policy" "this" {
  for_each    = local.iam_policy_config_to_create
  name        = each.value["name"]
  path        = each.value["path"]
  description = each.value["description"]
  policy      = join("", [for policy in data.aws_iam_policy_document.this : policy.json])
}

data "aws_iam_policy_document" "this" {
  for_each = local.iam_policy_config_to_create

  policy_id                 = each.value["policy_document_id"]
  override_policy_documents = length(each.value["override_policy_documents"]) > 0 ? each.value["override_policy_documents"] : null
  source_policy_documents   = length(each.value["source_policy_documents"]) > 0 ? each.value["source_policy_documents"] : null

  dynamic "statement" {
    for_each = each.value["statements"]
    iterator = statement

    content {
      sid           = lookup(statement.value, "sid", replace(each.key, "/[^0-9A-Za-z]/", ""))
      actions       = lookup(statement.value, "actions", null)
      not_actions   = lookup(statement.value, "not_actions", null)
      resources     = lookup(statement.value, "resources", null)
      not_resources = lookup(statement.value, "not_resources", null)

      dynamic "principals" {
        for_each = lookup(statement.value, "principals", [])

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = lookup(statement.value, "not_principals", [])

        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = lookup(statement.value, "conditions", [])

        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}
