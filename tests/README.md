# Terraform Module Tests: Terratests

## Overview
Terratest is a Go library that makes it easier to write automated tests for your infrastructure code.
It provides a variety of helper functions and patterns for common infrastructure testing tasks, including:
- Testing Terraform code
- Working with AWS APIs
- And much more

Official **terratest** [documentation available on GitHub project repo](https://github.com/gruntwork-io/terratest).
Ref Article [available on Medium maintainers blog](https://blog.gruntwork.io/open-sourcing-terratest-a-swiss-army-knife-for-testing-infrastructure-code-5d883336fcd5).

### Install requirements

Terratest uses the Go testing framework. To use terratest, you need to install:

- [Go](https://golang.org/) (requires version >=1.10)
- [dep](https://github.com/golang/dep) (requires version >=0.5.1)

## Files Organization
* Terraform files are located at the root of this directory.
* Tests can be found under tests/ directory.

## Testing
### Key Points
* We use `terratest` for testing this module.
* Keep in mind that `terratest` is not a binary but a Go library with helpers that make it easier to work with Terraform and other tools.
* Test files use `_test` suffix. E.g.: `create_file_with_default_values_test.go`
* Test classes use `Test` prefix. E.g.: `func TestCreateFileWithDefaultValues(t *testing.T) {`
* Our tests make use of a fixture/ dir that resembles how the module will be used.

### Set Up

#### Dokerized Makefile
```
$ make
Available Commands:
...
 - terratest-dep-init dep is a dependency management tool for Go. (https://github.com/golang/dep)
 - terratest-go-test  lint: TFLint is a Terraform linter for detecting errors that can not be detected by terraform plan.
...
```

1.  `make terratest-dep-init`
```
$ make terratest-dep-init
docker run --rm -v /home/delivery/Binbash/repos/BB-Leverage/terraform/terraform-aws-ec2-jenkins-vault:"/go/src/project/":rw -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/etc/gitconfig --entrypoint=dep -it binbash/terraform-resources:0.11.14 init
  Locking in master (da137c7) for transitive dep golang.org/x/net
  Using ^1.3.0 as constraint for direct dep github.com/stretchr/testify
  Locking in v1.3.0 (ffdc059) for direct dep github.com/stretchr/testify
  Locking in v1.0.0 (792786c) for transitive dep github.com/pmezard/go-difflib
  Using ^0.17.5 as constraint for direct dep github.com/gruntwork-io/terratest
  Locking in v0.17.5 (03959c9) for direct dep github.com/gruntwork-io/terratest
  Locking in v1.1.1 (8991bc2) for transitive dep github.com/davecgh/go-spew
  Locking in master (4def268) for transitive dep golang.org/x/crypto
  Locking in master (04f50cd) for transitive dep golang.org/x/sys
docker run --rm -v /home/delivery/Binbash/repos/BB-Leverage/terraform/terraform-aws-ec2-jenkins-vault:"/go/src/project/":rw -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/etc/gitconfig --entrypoint=dep -it binbash/terraform-resources:0.11.14 ensure
sudo chown -R delivery:delivery .
cp -r ./vendor ./tests/ && rm -rf ./vendor
cp -r ./Gopkg* ./tests/ && rm -rf ./Gopkg*
```

2. `terratest-go-test`
```
TestInstanceJenkinsVault 2019-07-08T02:42:42Z command.go:158: Destroy complete! Resources: 23 destroyed.
TestInstanceJenkinsVault 2019-07-08T02:42:42Z command.go:158:
...
TestInstanceJenkinsVault 2019-07-08T02:42:42Z command.go:158:
TestInstanceJenkinsVault 2019-07-08T02:42:42Z command.go:158: Warning: output "aws_s3_bucket_ssl_certificates_bucket_domain_name": must use splat syntax to access aws_s3_bucket.ssl_certificates_bucket attribute "bucket_domain_name", because it has "count" set; use aws_s3_bucket.ssl_certificates_bucket.*.bucket_domain_name to obtain a list of the attributes across all instances
TestInstanceJenkinsVault 2019-07-08T02:42:42Z command.go:158:
TestInstanceJenkinsVault 2019-07-08T02:42:42Z command.go:158:
PASS
ok      project/tests   227.167s
sudo chown -R delivery:delivery .

```

#### Local installed deps execution
* Make sure this module is within the **GOPATH directory**.
    * Default GOPATH is usually set to `$HOME/go` but you can override that permanently or temporarily.
    * For instance, you could place all your modules under `/home/john.doe/project_name/tf-modules/src/`
    * Then you would use `export GOPATH=/home/john.doe/project_name/tf-modules/`
    * Or you could simply place all your modules under `$HOME/go/src/`
* Go to the `tests/` dir and run `dep ensure` to resolve all dependencies.
    * This should create a `vendor/` dir under `tests/` dir and also a `pkg/` dir under the GOPATH dir.
* Now you can run `go test`


### Tests Result: Passing
```
estAWSBudget 2019-09-18T20:23:06Z command.go:158: module.terraform-aws-cost-budget-test.aws_sns_topic.sns_alert_topic: Creating...
TestAWSBudget 2019-09-18T20:23:06Z command.go:158:   arn:    "" => "<computed>"
TestAWSBudget 2019-09-18T20:23:06Z command.go:158:   name:   "" => "budget-billing-alarm-notification-usd-dev-50-percent"
TestAWSBudget 2019-09-18T20:23:06Z command.go:158:   policy: "" => "<computed>"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158: module.terraform-aws-cost-budget-test.aws_sns_topic.sns_alert_topic: Creation complete after 3s (ID: arn:aws:sns:us-east-1:523857393444:budg...-alarm-notification-usd-dev-50-percent)
TestAWSBudget 2019-09-18T20:23:09Z command.go:158: module.terraform-aws-cost-budget-test.data.aws_iam_policy_document.sns-topic-policy: Refreshing state...
TestAWSBudget 2019-09-18T20:23:09Z command.go:158: module.terraform-aws-cost-budget-test.aws_budgets_budget.budget_notif_to_new_sns_specific_servs_with_time_end: Creating...
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   account_id:                                                   "" => "<computed>"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   budget_type:                                                  "" => "COST"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   cost_filters.%:                                               "" => "1"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   cost_filters.Service:                                         "" => "Amazon Elastic Compute Cloud - Compute"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   cost_types.#:                                                 "" => "1"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   cost_types.0.include_credit:                                  "" => "true"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   cost_types.0.include_discount:                                "" => "true"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   cost_types.0.include_other_subscription:                      "" => "true"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   cost_types.0.include_recurring:                               "" => "true"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   cost_types.0.include_refund:                                  "" => "true"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   cost_types.0.include_subscription:                            "" => "true"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   cost_types.0.include_support:                                 "" => "true"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   cost_types.0.include_tax:                                     "" => "true"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   cost_types.0.include_upfront:                                 "" => "true"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   cost_types.0.use_amortized:                                   "" => "false"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   cost_types.0.use_blended:                                     "" => "false"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   limit_amount:                                                 "" => "500"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   limit_unit:                                                   "" => "USD"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   name:                                                         "" => "budget-Amazon Elastic Compute Cloud - Compute-MONTHLY-dev-50-percent"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   name_prefix:                                                  "" => "<computed>"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   notification.#:                                               "" => "1"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   notification.3676559820.comparison_operator:                  "" => "GREATER_THAN"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   notification.3676559820.notification_type:                    "" => "FORECASTED"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   notification.3676559820.subscriber_email_addresses.#:         "" => "0"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   notification.3676559820.subscriber_sns_topic_arns.#:          "" => "1"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   notification.3676559820.subscriber_sns_topic_arns.1535440086: "" => "arn:aws:sns:us-east-1:523857393444:budget-billing-alarm-notification-usd-dev-50-percent"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   notification.3676559820.threshold:                            "" => "50"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   notification.3676559820.threshold_type:                       "" => "PERCENTAGE"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   time_period_end:                                              "" => "2019-12-31_23:59"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   time_period_start:                                            "" => "2019-01-01_00:00"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   time_unit:                                                    "" => "MONTHLY"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158: module.terraform-aws-cost-budget-test.aws_sns_topic_policy.default: Creating...
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   arn:    "" => "arn:aws:sns:us-east-1:523857393444:budget-billing-alarm-notification-usd-dev-50-percent"
TestAWSBudget 2019-09-18T20:23:09Z command.go:158:   policy: "" => "{\n  \"Version\": \"2012-10-17\",\n  \"Id\": \"__default_policy_ID\",\n  \"Statement\": [\n    {\n      \"Sid\": \"_budgets_service_access_ID\",\n      \"Effect\": \"Allow\",\n      \"Action\": \"SNS:Publish\",\n      \"Resource\": \"arn:aws:sns:us-east-1:523857393444:budget-billing-alarm-notification-usd-dev-50-percent\",\n      \"Principal\": {\n        \"Service\": \"budgets.amazonaws.com\"\n      }\n    },\n    {\n      \"Sid\": \"__default_statement_ID\",\n      \"Effect\": \"Allow\",\n      \"Action\": [\n        \"SNS:Subscribe\",\n        \"SNS:SetTopicAttributes\",\n        \"SNS:RemovePermission\",\n        \"SNS:Receive\",\n        \"SNS:Publish\",\n        \"SNS:ListSubscriptionsByTopic\",\n        \"SNS:GetTopicAttributes\",\n        \"SNS:DeleteTopic\",\n        \"SNS:AddPermission\"\n      ],\n      \"Resource\": \"arn:aws:sns:us-east-1:523857393444:budget-billing-alarm-notification-usd-dev-50-percent\",\n      \"Principal\": {\n        \"AWS\": \"*\"\n      },\n      \"Condition\": {\n        \"StringEquals\": {\n          \"AWS:SourceOwner\": \"523857393444\"\n        }\n      }\n    }\n  ]\n}"
TestAWSBudget 2019-09-18T20:23:11Z command.go:158: module.terraform-aws-cost-budget-test.aws_sns_topic_policy.default: Creation complete after 2s (ID: arn:aws:sns:us-east-1:523857393444:budg...-alarm-notification-usd-dev-50-percent)
TestAWSBudget 2019-09-18T20:23:15Z command.go:158: module.terraform-aws-cost-budget-test.aws_budgets_budget.budget_notif_to_new_sns_specific_servs_with_time_end: Creation complete after 5s (ID: 523857393444:budget-Amazon Elastic Comp...Cloud - Compute-MONTHLY-dev-50-percent)
TestAWSBudget 2019-09-18T20:23:15Z command.go:158:
TestAWSBudget 2019-09-18T20:23:15Z command.go:158: Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
...

TestInstanceJenkinsVault 2019-07-07T22:33:03-03:00 command.go:158:
PASS
ok      terraform-aws-ec2-jenkins-vault/tests   222.625s
```


## Code Linting & Static Code Analysis

* The `terraform fmt` command is used to rewrite Terraform configuration files to a canonical format and style.
  This command applies a subset of the Terraform language style conventions, along with other minor adjustments for
  readability. (https://www.terraform.io/docs/commands/fmt.html)
* TFLint is a Terraform linter focused on possible errors, best practices, etc. (https://github.com/wata727/tflint)

```
# delivery @ delivery-I7567 in ~/Binbash/repos/BB-Leverage/terraform/terraform-aws-cost-budget on git:BBL-121-fix-budget-sns-policy x [15:32:08]
$ make
Available Commands:
 ...
 - format             The terraform fmt is used to rewrite tf conf files to a canonical format and style.
 - lint               TFLint is a Terraform linter for detecting errors that can not be detected by terraform plan.
 ...

# delivery @ delivery-I7567 in ~/Binbash/repos/BB-Leverage/terraform/terraform-aws-cost-budget on git:BBL-121-fix-budget-sns-policy o [15:31:47]
$ make format
docker run --rm -v /home/delivery/Binbash/repos/BB-Leverage/terraform/terraform-aws-cost-budget:"/go/src/project/":rw --entrypoint=/usr/local/go/bin/terraform -it binbash/terraform-resources:0.11.14 fmt "/go/src/project/"
/go/src/project/outputs.tf
/go/src/project/sns.tf
/go/src/project/tests/fixture/main.tf
/go/src/project/tests/fixture/outputs.tf
/go/src/project/tests/fixture/variables.tf



# delivery @ delivery-I7567 in ~/Binbash/repos/BB-Leverage/terraform/terraform-aws-cost-budget on git:BBL-121-fix-budget-sns-policy x [15:34:45]
$ make lint
docker run --rm -v /home/delivery/Binbash/repos/BB-Leverage/terraform/terraform-aws-cost-budget:/data -t wata727/tflint --deep
Awesome! Your code is following the best practices :)
```