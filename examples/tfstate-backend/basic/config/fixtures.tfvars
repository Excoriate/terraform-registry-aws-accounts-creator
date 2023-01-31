aws_region = "us-east-1"
is_enabled = true

backend_config = [
  {
    name                    = "mytfstate-backend"
    enable_s3_backend       = true
    enable_dynamodb_backend = true
  }
]
