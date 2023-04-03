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

func GetInlinePolicyForIAMUser(t *testing.T, userName string) *iam.GetPolicyOutput {
  awsAuth, err := config.LoadDefaultConfig(context.TODO(), config.WithRegion("us-east-1"))
  assert.NoError(t, err)
  assert.NotNil(t, awsAuth)

  iamClient := iam.NewFromConfig(awsAuth)
  listUserPoliciesOutput, err := iamClient.ListUserPolicies(context.TODO(), &iam.ListUserPoliciesInput{
    UserName: aws.String(userName),
  })

  assert.NoError(t, err)
  assert.NotNil(t, listUserPoliciesOutput)
  assert.NotEmpty(t, listUserPoliciesOutput.PolicyNames)

  // Assuming there's only one inline policy
  policyName := listUserPoliciesOutput.PolicyNames[0]

  getPolicyOutput, err := iamClient.GetPolicy(context.TODO(), &iam.GetPolicyInput{
    PolicyArn: aws.String(policyName),
  })

  assert.NoError(t, err)
  assert.NotNil(t, getPolicyOutput)

  return getPolicyOutput
}
