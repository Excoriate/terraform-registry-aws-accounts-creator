aws_region = "us-east-1"
is_enabled = true

iam_user_config = [
  {
    name = "testuser"
  },
  {
    name = "another-user"
  }
]

iam_user_permissions_config = [
  {
    name               = "another-user"
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
  {
    name               = "testuser"
    policy_inline_json = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:AttachVolume",
        "ec2:DetachVolume",
        "ec2:DeleteVolume"
      ],
      "Resource": "*"
    }
  ]
}
EOF
  }
]
