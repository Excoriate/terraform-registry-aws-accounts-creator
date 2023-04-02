package tf

import (
  "fmt"
  "github.com/gruntwork-io/terratest/modules/terraform"
  "testing"
)

func GetTerraformOptions(inputVars map[string]interface{}, recipe string, t *testing.T) *terraform.Options {
  if recipe == "" {
    t.Logf("No recipe provided, using default recipe: basic")
    recipe = "basic"
  }

  targetPath := fmt.Sprintf("%s/%s", SRC, recipe)
  t.Logf("Using recipe: %s", targetPath)

  return &terraform.Options{
    TerraformDir: targetPath,
    Vars:         inputVars,
    Upgrade:      false,
  }
}
