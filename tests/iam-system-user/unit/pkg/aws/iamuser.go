package aws

import (
  "context"
  "github.com/aws/aws-sdk-go-v2/aws"
  "github.com/aws/aws-sdk-go-v2/config"
  "github.com/aws/aws-sdk-go-v2/service/iam"
  "github.com/stretchr/testify/assert"
  "testing"
)

func GetIAMUser(t *testing.T, userName string) *iam.GetUserOutput {
  awsAuth, err := config.LoadDefaultConfig(context.TODO(), config.WithRegion("us-east-1"))
  assert.NoError(t, err)
  assert.NotNil(t, awsAuth)

  iamClient := iam.NewFromConfig(awsAuth)
  iamUser, err := iamClient.GetUser(context.TODO(), &iam.GetUserInput{
    UserName: aws.String(userName),
  })

  assert.NoError(t, err)
  assert.NotNil(t, iamUser)

  return iamUser
}
