package test

import (
  "github.com/Excoriate/terraform-registry-aws-account-creator/iam-system-user/pkg/scenario"
  "github.com/Excoriate/terraform-registry-aws-account-creator/iam-system-user/pkg/tf"
  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/assert"
  "testing"
)

var recipe = "basic"

// Set of default outputs.
var outputs = []string{
  "iam_user_id",
  "iam_user_arn",
  "iam_user_name",
  "iam_user_path",
  "iam_user_permissions_boundary",
}

func TestBasicSystemUserConfigurations(t *testing.T) {
  // Given
  iamUser := tf.GetRandomUserName()
  scenarioVars := map[string]interface{}{
    "is_enabled": false,
    "iam_user_config": []map[string]interface{}{
      {
        "name": iamUser,
      },
    },
  }

  inputVars := tf.MergeVars(tf.GetCommonInputVarsValues(), scenarioVars)

  terraformOptions := tf.GetTerraformOptions(inputVars, recipe, t)
  terraform.Init(t, terraformOptions)
  defer terraform.Destroy(t, terraformOptions)

  // Then
  t.Run("A plan with an IAM user with just its name", func(t *testing.T) {
    out, err := terraform.PlanE(t, terraformOptions)
    assert.NoError(t, err)
    assert.Contains(t, out, "You can apply this plan to save these new output values to the Terraform")
  })
}

func TestBasicSystemUserCreation(t *testing.T) {
  // Given
  iamUser := tf.GetRandomUserName()
  scenarioVars := map[string]interface{}{
    "is_enabled": true,
    "iam_user_config": []map[string]interface{}{
      {
        "name": iamUser,
      },
    },
  }

  inputVars := tf.MergeVars(tf.GetCommonInputVarsValues(), scenarioVars)

  terraformOptions := tf.GetTerraformOptions(inputVars, recipe, t)
  terraform.Init(t, terraformOptions)
  out, err := terraform.ApplyE(t, terraformOptions)
  defer terraform.Destroy(t, terraformOptions)

  t.Run("An IAM user with just its name is created", func(t *testing.T) {
    assert.NoError(t, err)
    assert.Contains(t, out, "Apply complete! Resources: 1 added, 0 changed, 0 destroyed.")
  })

  t.Run("Outputs are expressed in the mutated tfstate file", func(t *testing.T) {
    scenario.OutputsAreNotEmpty(t, terraformOptions, outputs)
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
}
