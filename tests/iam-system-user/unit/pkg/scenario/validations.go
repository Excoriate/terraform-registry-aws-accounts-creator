package scenario

import (
  "github.com/Excoriate/terraform-registry-aws-account-creator/iam-system-user/pkg/aws"
  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/assert"
  "testing"
)

type NoEmptyValidationOpt struct {
  ToValidate []string
  ToTolerate []string
}

func OutputsAreNotEmpty(t *testing.T, tfOpt *terraform.Options, validationOpt NoEmptyValidationOpt) {
  stringInSlice := func(str string, slice []string) bool {
    for _, s := range slice {
      if s == str {
        return true
      }
    }
    return false
  }

  for _, output := range validationOpt.ToValidate {
    if stringInSlice(output, validationOpt.ToTolerate) {
      continue
    }

    assert.NotEmpty(t, output, "Output %s is empty", output)
    tfOut := terraform.OutputList(t, tfOpt, output)
    assert.NotEmpty(t, tfOut, "Terraform output %s is empty", output)
  }
}

func UserInAWSIsSuccessfullyCreated(t *testing.T, userName, userPath string) {
  iamUser := aws.GetIAMUser(t, userName)
  assert.NotEmpty(t, iamUser.User.UserName, "IAM user %s is not created", userName)

  userARN := *iamUser.User.Arn
  assert.NotEmpty(t, userARN, "IAM user %s ARN is empty", userName)
  assert.Containsf(t, userARN, userName, "IAM user %s ARN does not contain user name", userName)

  userPathAWS := *iamUser.User.Path
  if userPath == "" {
    userPath = "/"
    assert.Equal(t, "/", userPathAWS, "IAM user %s path is not '/'", userName)
  } else {
    assert.Contains(t, userPath, userPathAWS, "IAM user %s path does not contain user path", userName)
  }

  assert.NotEmpty(t, userPath, "IAM user %s path is empty", userName)
}

func UserInAWSHasValidKeys(t *testing.T, userName string) {
  iamUserKeys := aws.GetIAMUserKeys(t, userName)
  assert.NotEmpty(t, iamUserKeys.AccessKeyMetadata, "IAM user %s has no access keys", userName)

  for _, key := range iamUserKeys.AccessKeyMetadata {
    assert.NotEmpty(t, key.AccessKeyId, "IAM user %s has no access key ID", userName)
    assert.NotEmpty(t, key.Status, "IAM user %s has no access key status", userName)
    assert.NotNil(t, key.Status, "IAM user %s has inactive access key", userName)
  }
}
