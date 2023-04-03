package test

import (
  "github.com/Excoriate/terraform-registry-aws-account-creator/iam-system-user/pkg/scenario"
  "github.com/Excoriate/terraform-registry-aws-account-creator/iam-system-user/pkg/tf"
  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/assert"
  "testing"
)

func TestSystemUserAWSKeys(t *testing.T) {
  // Given
  iamUser := tf.GetRandomUserName()

  scenarioVars := map[string]interface{}{
    "is_enabled": true,
    "iam_user_config": []map[string]interface{}{
      {
        "name": iamUser,
      },
    },
    "iam_user_credentials_config": []map[string]interface{}{
      {
        "name":    iamUser,
        "enabled": true,
      },
    },
  }

  inputVars := tf.MergeVars(tf.GetCommonInputVarsValues(), scenarioVars)

  terraformOptions := tf.GetTerraformOptions(inputVars, recipe, t)
  terraform.Init(t, terraformOptions)
  out, err := terraform.PlanE(t, terraformOptions)
  defer terraform.Destroy(t, terraformOptions)

  t.Run("An IAM user with AWS keys is planned", func(t *testing.T) {
    assert.NoError(t, err)
    assert.Contains(t, out, "2 to add, 0 to change, 0 to destroy")
  })
}

func TestSystemUserWithKeysCreation(t *testing.T) {
  // Given
  iamUser := tf.GetRandomUserName()

  scenarioVars := map[string]interface{}{
    "is_enabled": true,
    "iam_user_config": []map[string]interface{}{
      {
        "name": iamUser,
      },
    },
    "iam_user_credentials_config": []map[string]interface{}{
      {
        "name":    iamUser,
        "enabled": true,
      },
    },
  }

  inputVars := tf.MergeVars(tf.GetCommonInputVarsValues(), scenarioVars)

  terraformOptions := tf.GetTerraformOptions(inputVars, recipe, t)
  terraform.Init(t, terraformOptions)
  out, err := terraform.ApplyE(t, terraformOptions)
  defer terraform.Destroy(t, terraformOptions)

  t.Run("An IAM user with an AWS key is created", func(t *testing.T) {
    assert.NoError(t, err)
    assert.Contains(t, out, "Apply complete! Resources: 2 added, 0 changed, 0 destroyed.")
  })

  t.Run("Outputs are expressed in the mutated tfstate file", func(t *testing.T) {
    scenario.OutputsAreNotEmpty(t, terraformOptions, scenario.NoEmptyValidationOpt{
      ToValidate: outputs,
      ToTolerate: []string{
        "iam_user_policy_inline_id",
        "iam_user_policy_inline_name",
        "iam_user_policy_inline_policy",
        "iam_user_policy_attached_id",
        "iam_user_policy_attached_arn",
      },
    })
  })

  t.Run("The output values match the input values", func(t *testing.T) {
    iamUserOutput := terraform.OutputList(t, terraformOptions, "iam_user_name")
    iamUserARN := terraform.OutputList(t, terraformOptions, "iam_user_arn")
    iamUserID := terraform.OutputList(t, terraformOptions, "iam_user_id")

    assert.Equal(t, iamUser, iamUserOutput[0])
    assert.Contains(t, iamUserARN[0], iamUser)
    assert.Contains(t, iamUserID[0], iamUser)
  })

  t.Run("The IAM user is verified through the AWS APIs", func(t *testing.T) {
    iamUserName := terraform.OutputList(t, terraformOptions, "iam_user_name")[0]
    scenario.UserInAWSIsSuccessfullyCreated(t, iamUserName, "")
  })

  t.Run("The IAM user keys are verified through the AWS APIs", func(t *testing.T) {
    iamUserName := terraform.OutputList(t, terraformOptions, "iam_user_name")[0]
    scenario.UserInAWSHasValidKeys(t, iamUserName)
  })
}
