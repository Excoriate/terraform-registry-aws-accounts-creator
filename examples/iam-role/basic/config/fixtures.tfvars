aws_region = "us-east-1"
is_enabled = true

// Very simple usage.
iam_role_config = [
  {
    name = "my-test-role"
    assume_role_config = {
      principals = [
        {
          type        = "Service"
          identifiers = ["ec2.amazonaws.com"]
        }
      ]
    }
  }
]
