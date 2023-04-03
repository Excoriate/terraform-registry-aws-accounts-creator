aws_region = "us-east-1"
is_enabled = true

iam_user_config = [
  {
    name = "user-with-keys"
  },
  {
    name = "another-with-keys"
  },
  {
    name = "user-without-keys"
  }
]

iam_user_credentials_config = [
  {
    name    = "user-with-keys"
    enabled = true
  },
  {
    name    = "another-with-keys"
    enabled = true
    status  = "Inactive"
  }
]


iam_user_permissions_config = [
  {
    name               = "user-with-keys"
    policy_inline_json = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "S3BucketPolicy",
      "Effect": "Allow",
      "Action": [
       "s3:ListBucket",
        "s3:GetBucketLocation"
      ],
      "Resource": "*"
    }
  ]
}
EOF
  },
]
