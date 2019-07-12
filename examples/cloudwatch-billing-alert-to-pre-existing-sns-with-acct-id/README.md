# AWS Billing Alert
## cloudwatch-billing-alert-to-pre-existing-sns-with-acct-id

Configuration in this directory creates set of AWS resources which may be sufficient for a fully working stage or prod
billing alert with optional sns topic creation (or use a pre-existing one) to alert when
a U$S (currency actually configurable) billing threshold is reached.

Please check the **input parameters** for a better understanding of it.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Or if using the `Makefile` in this repo you need to execute:

```bash
$ make init
$ make plan
$ make apply
```

Note that this example may create resources which can cost money (AWS EC2, for example). Run `terraform destroy` or `make destroy`
when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Outputs

| Name | Description |
|------|-------------|
| sns\_topic\_arn | SNS Topic ARN to be subscribed to in order to delivery the clodwatch billing alarms

The module outputs one block, sns_topic. Access it like this:

```
output "sns_topic" {
  value = "${module.billing_alert.sns_topic}"
}
```

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## cloudwatch-billing-alert-to-pre-existing-sns-consolidated-acct
```terraform
module "billing_cloudwatch_alert" {
  source = "../../cost-mgmt-billing-alarm-bb"

  aws_env                   = "${var.aws_profile}"
  aws_account_id            = 111111111111
  monthly_billing_threshold = 500
  currency                  = "USD"
  aws_sns_topic_arn         = "arn:aws:lambda:us-east-1:111111111111:function:bb-root-org-notify_slack"
}
```
