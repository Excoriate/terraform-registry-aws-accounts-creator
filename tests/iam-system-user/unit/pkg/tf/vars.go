package tf

import (
  "fmt"
  "github.com/gruntwork-io/terratest/modules/random"
  "strings"
)

func GetCommonInputVarsValues() map[string]interface{} {
  return map[string]interface{}{
    "aws_region": AWSRegion,
    "tags": map[string]string{
      "owner":      "test",
      "managed_by": "terratest",
    },
  }
}

func MergeVars(maps ...map[string]interface{}) map[string]interface{} {
  result := make(map[string]interface{})
  for _, m := range maps {
    for k, v := range m {
      result[k] = v
    }
  }
  return result
}

func GetRandomUserName() string {
  return fmt.Sprintf("test-user-%s", strings.ToLower(random.UniqueId()))
}
