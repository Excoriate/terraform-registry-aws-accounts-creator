locals {
  is_enabled = !var.is_enabled ? false : var.backend_config == null ? false : length(var.backend_config) == 0 ? false : true

  aws_region_to_deploy = var.aws_region

  remote_backend_normalized = var.backend_config == null ? [] : [
    for component in var.backend_config : {
      name                          = var.backend_optionals.force_lower_case ? trimspace(lower(component.name)) : trimspace(component.name)
      enable_dynamodb_backend       = component["enable_dynamodb_backend"] == null ? false : component["enable_dynamodb_backend"]
      enable_s3_backend             = component["enable_s3_backend"] == null ? false : component["enable_s3_backend"]
      enable_server_side_encryption = var.backend_optionals.enable_server_side_encryption
      dynamodb = component["enable_dynamodb_backend"] == null ? false : component["enable_dynamodb_backend"] ? {
        billing_mode                  = var.dynamodb_optional_config.billing_mode
        read_capacity                 = var.dynamodb_optional_config.read_capacity
        write_capacity                = var.dynamodb_optional_config.write_capacity
        enable_point_in_time_recovery = var.dynamodb_optional_config.enable_point_in_time_recovery
      } : {}
    }
  ]

  // Convert it into a map for easier access only if the dynamodb attribute has keys (isn't an empty map)
  remote_backend_dynamodb = { for k, v in local.remote_backend_normalized : k => v if length(v["dynamodb"]) > 0 }
  remote_backend_dynamodb_normalised = { for k, v in local.remote_backend_dynamodb : k => {
    name                          = v["name"]
    billing_mode                  = v["dynamodb"]["billing_mode"]
    read_capacity                 = v["dynamodb"]["read_capacity"]
    write_capacity                = v["dynamodb"]["write_capacity"]
    hash_key                      = "LockID"
    enable_server_side_encryption = v["enable_server_side_encryption"]
    enable_point_in_time_recovery = v["dynamodb"]["enable_point_in_time_recovery"]
  } }
}
