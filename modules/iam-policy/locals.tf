locals {
  aws_region_to_deploy = var.aws_region

  /*
    * -------------------------------------------------------
    * IAM Policy feature flags, and other options.
    * -------------------------------------------------------
  */
  is_iam_policy_enabled = !var.is_enabled ? false : var.iam_policy_config == null ? false : length(var.iam_policy_config) == 0 ? false : true

  iam_policy_config_normalised = !local.is_iam_policy_enabled ? [] : [
    for p in var.iam_policy_config : {
      name               = lower(trimspace(p["name"]))
      policy_document_id = p["policy_document_id"] == null ? null : lower(trimspace(p["policy_document_id"]))
      description        = lower(trimspace(p["description"]))
      path               = p["path"] == null ? null : lower(trimspace(p["path"]))
      // Statement block
      statements = p["statements"] != null ? [
        for s in p["statements"] : {
          sid    = s["sid"] == null ? null : lower(trimspace(s["sid"]))
          effect = trimspace(s["effect"])
          actions = s["actions"] != null ? [
            for a in s["actions"] : lower(trimspace(a))
          ] : []
          not_actions = s["not_actions"] != null ? [
            for a in s["no_actions"] : lower(trimspace(a))
          ] : []
          resources = s["resources"] != null ? [
            for r in s["resources"] : lower(trimspace(r))
          ] : []
          not_resources = s["not_resources"] != null ? [
            for r in s["no_resources"] : lower(trimspace(r))
          ] : []
          principals : s["principals"] != null ? [
            for p in s["principals"] : {
              type = lower(trimspace(p["type"]))
              identifiers = [
                for i in p["identifiers"] : lower(trimspace(i))
              ]
            }
          ] : []
          not_principals : s["not_principals"] != null ? [
            for p in s["not_principals"] : {
              type = lower(trimspace(p["type"]))
              identifiers = [
                for i in p["identifiers"] : lower(trimspace(i))
              ]
            }
          ] : []
          conditions = s["conditions"] == null ? [] : [
            for c in s["conditions"] : {
              test     = lower(trimspace(c["test"]))
              variable = lower(trimspace(c["variable"]))
              values = [
                for v in c["values"] : lower(trimspace(v))
              ]
            }
          ]
        }
      ] : []
      source_policy_documents   = p["source_policy_documents"]
      override_policy_documents = p["override_policy_documents"]
    }
  ]

  iam_policy_config_to_create = !local.is_iam_policy_enabled ? {} : {
    for p in local.iam_policy_config_normalised : p["name"] => {
      name                      = p["name"]
      policy_document_id        = p["policy_document_id"]
      path                      = p["path"]
      description               = p["description"]
      statements                = p["statements"]
      source_policy_documents   = p["source_policy_documents"]
      override_policy_documents = p["override_policy_documents"]
    }
  }
}
