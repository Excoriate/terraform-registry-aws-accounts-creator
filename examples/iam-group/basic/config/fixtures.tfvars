aws_region = "us-east-1"
is_enabled = true

groups_config = [
  {
    name = "test-group"
    path = "/"
  },
  {
    name = "test-another"
    path = "/something"
  },
  {
    name = "test-nopath"
  },
]
