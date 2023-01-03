package unit

import (
  "testing"

  "github.com/gruntwork-io/terratest/modules/aws"
  "github.com/gruntwork-io/terratest/modules/terraform"
)

func getInputVarsValues(t *testing.T, isEnabled bool) map[string]interface{} {
  randomAwsRegion := aws.GetRandomRegion(t, nil, nil)

  return map[string]interface{}{
    "aws_region": randomAwsRegion,
    "is_enabled": isEnabled,
    "aws_org_config": map[string]interface{}{
      "aws_accounts": []interface{}{
        map[string]interface{}{
          "name":  "test",
          "email": "test@example.com",
        },
      },
    },
  }
}

func TestDefaultBasicUnitIsDisabled(t *testing.T) {
  t.Parallel()

  terraformOptions := &terraform.Options{
    TerraformDir: "target/basic",
    Vars:         getInputVarsValues(t, false),
    Upgrade:      false,
  }

  terraform.Init(t, terraformOptions)

  terraform.Plan(t, terraformOptions)
}

func TestDefaultBasicUnitIsEnabled(t *testing.T) {
  t.Parallel()

  terraformOptions := &terraform.Options{
    TerraformDir: "target/basic",
    Vars:         getInputVarsValues(t, true),
    Upgrade:      false,
  }

  terraform.Init(t, terraformOptions)

  terraform.Plan(t, terraformOptions)
}
