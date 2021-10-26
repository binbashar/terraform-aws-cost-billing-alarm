package tests

import (
    "testing"
    "os"
    "fmt"

    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestAWSBudget(t *testing.T) {

    //expectedBudgetSnsTopicArn := "arn:aws:sns:us-east-1:523857393444:billing-alarm-notification-usd-bb-dev-deploymaster"
    expectedBudgetSnsTopicArn := fmt.Sprintf("arn:aws:sns:us-east-1:%s:billing-alarm-notification-usd-bb-dev-deploymaster", os.Getenv("AWS_ACCOUNT_ID"))
    expectedList := []string{expectedBudgetSnsTopicArn}

    terraformOptions := &terraform.Options {
        // The path to where our Terraform code is located
        TerraformDir: "fixture/",

        // Disable colors in Terraform commands so its easier to parse stdout/stderr
        NoColor: true,
    }

    // At the end of the test, run `terraform destroy` to clean up any resources that were created
    defer terraform.Destroy(t, terraformOptions)

    // This will run `terraform init` and `terraform apply` and fail the test if there are any errors
    terraform.InitAndApply(t, terraformOptions)

    // Run `terraform output` to get the values of output variables
    actualList       := terraform.OutputList(t, terraformOptions, "budget_sns_topic_arn")

    // Verify we're getting back the outputs we expect
    assert.Equal(t, expectedList, actualList)
}
