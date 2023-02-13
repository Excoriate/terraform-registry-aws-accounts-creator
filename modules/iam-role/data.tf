data "aws_iam_policy_document" "assume_role" {
  for_each = local.iam_role_config_to_create

  statement {
    effect  = "Allow"
    actions = each.value["actions"]

    dynamic "principals" {
      for_each = each.value["principals"]
      content {
        type        = principals.value["type"]
        identifiers = principals.value["identifiers"]
      }
    }

    dynamic "condition" {
      for_each = each.value["conditions"]
      content {
        test     = condition.value["test"]
        variable = condition.value["variable"]
        values   = condition.value["values"]
      }
    }
  }
}

data "aws_iam_policy_document" "assume_role_aggregated" {
  for_each = local.iam_role_config_to_create
  override_policy_documents = [
    data.aws_iam_policy_document.assume_role[each.key].json
  ]
}

data "aws_iam_policy_document" "default" {
  for_each                  = { for k, v in local.iam_role_config_to_create : k => v if v["default_iam_policy_json"] != null }
  override_policy_documents = each.value["default_iam_policy_json"]
}

data "aws_iam_policy_document" "extra_policies" {
  for_each                  = { for k, v in local.iam_role_config_to_create : k => v if length(v["iam_policy_documents_json"]) > 0 }
  override_policy_documents = each.value["iam_policy_documents_json"]
}
