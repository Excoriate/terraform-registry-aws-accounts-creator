package scenario

import (
  "encoding/json"
  "testing"
)

func GenerateIAMPolicyJSON(t *testing.T) string {
  iamPolicy := map[string]interface{}{
    "Version": "2012-10-17",
    "Statement": []map[string]interface{}{
      {
        "Sid":      "TestInlinePol0",
        "Effect":   "Allow",
        "Action":   "s3:*",
        "Resource": "*",
      },
    },
  }

  iamPolicyJson, err := json.Marshal(iamPolicy)
  if err != nil {
    t.Fatalf("Failed to marshal IAM policy: %v", err)
  }

  return string(iamPolicyJson)
}
