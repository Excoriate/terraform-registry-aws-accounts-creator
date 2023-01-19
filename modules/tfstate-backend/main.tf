resource "aws_dynamodb_table" "this" {
  for_each       = local.remote_backend_dynamodb_normalised
  name           = each.value["name"]
  billing_mode   = each.value["billing_mode"]
  read_capacity  = each.value["read_capacity"]
  write_capacity = each.value["write_capacity"]

  hash_key = each.value["hash_key"]

  server_side_encryption {
    enabled = each.value["enable_server_side_encryption"]
  }

  point_in_time_recovery {
    enabled = each.value["enable_point_in_time_recovery"]
  }

  attribute {
    name = each.value["hash_key"]
    type = "S"
  }

  tags = var.tags
}
