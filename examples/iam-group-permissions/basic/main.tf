module "main_module" {
  source     = "../../../modules/iam-group-permissions"
  is_enabled = var.is_enabled
  aws_region = var.aws_region
  group_permissions_config = [
    {
      group_name = "dev"
      policy = jsonencode({
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Effect" : "Allow",
            "Action" : [
              "ec2:*"
            ],
            "Resource" : "*"
          }
        ]
      })
    }
  ]
}
