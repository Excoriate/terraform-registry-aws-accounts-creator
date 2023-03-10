aws_region = "us-east-1"
is_enabled = true

iam_policy_config = [
  {
    name = "test-policy"
    statements = [
      {
        sid    = "teststatement1"
        effect = "Allow"
        actions = [
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation"
        ]
        resources = [
          "arn:aws:s3:::*"
        ]
      }
    ]
  }
]
