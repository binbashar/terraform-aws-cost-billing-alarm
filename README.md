<div align="center">
    <img src="https://binbashar.github.io/terraform-aws-cost-billing-alarm/figures/binbash.png" alt="drawing" width="350"/>
</div>
<div align="right">
  <img src="figures/binbash-leverage-terraform.png" alt="leverage" width="230"/>
</div>

# AWS Billing Cloudwatch Alarm terraform module: terraform-aws-cost-mgmt-billing-alarm

Adds a billing alert with optional sns topic creation (or use a pre-existing one) to alert when a U$S (currency actually configurable) billing threshold is reached.

If `aws_sns_topic_enabled = true` then you'll still need to subscribe to the created SNS topic manually (please check **Important Consderations** section for detailed info).

## Inputs

There are several required variables for this module.
* The `aws_env` -> environment this is running in (e.g. dev, stage, prod).
* The `monthly_billing_threshold` -> threshold of estimated charges that will trigger the alarm (a monetary amount).
* Currency is an optional variable. It defaults to USD, however you can provide any currency abbreviation (e.g. CAD, EUR, JPY) so you can seperate billing alerts by currency. I don't know if that's a common thing, but it's a provided dimension by Amazon, so I added support for it here.

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_account\_id | AWS account id | string | `""` | no |
| aws\_env | AWS environment you are deploying to. Will be appended to SNS topic and alarm name. (e.g. dev, stage, prod) | string | n/a | yes |
| aws\_sns\_topic\_arn | If aws_sns_topic_enabled = false, then an existing AWS SNS topic ARN for the billing alert integration will be used | string | `""` | no |
| currency | Short notation for currency type (e.g. USD, CAD, EUR) | string | `"USD"` | no |
| monthly\_billing\_threshold | The threshold for which estimated monthly charges will trigger the metric alarm. | string | n/a | yes |
| tags | A mapping of tags to assign to all resources | map | `<map>` | no |

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

## Examples

### For an specific account
#### cloudwatch-billing-alert-to-new-sns-with-acct-id
```terraform
module "billing_alert" {
  source = "billtrust/billing-alarm/aws"

  aws_env = "${var.aws_profile}"
  aws_account_id = 111111111111
  monthly_billing_threshold = 500
  currency = "USD"
}

output "sns_topic" {
  value = "${module.billing_alert.sns_topic}"
}
# Will output the following:
# arn:aws:sns:us-east-1:111111111111:billing-alarm-notification-usd-dev for billing alarms
```

#### cloudwatch-billing-alert-to-pre-existing-sns-with-acct-id
``` terraform
module "billing_cloudwatch_alert" {
  source = "billtrust/billing-alarm/aws"

  aws_env = "${var.aws_profile}"
  aws_account_id = 111111111111
  monthly_billing_threshold = 500
  currency = "USD"
}
```

### For a consolidated billing account aws-org like approach (or single account)
#### cloudwatch-billing-alert-to-new-sns-with-consolidated-acct
```terraform
module "billing_alert" {
  source = "billtrust/billing-alarm/aws"

  aws_env = "${var.aws_profile}"
  monthly_billing_threshold = 500
  currency = "USD"
}

output "sns_topic" {
  value = "${module.billing_alert.sns_topic}"
}
# Will output the following:
# arn:aws:sns:us-east-1:111111111111:billing-alarm-notification-usd-dev for billing alarms
```

#### cloudwatch-billing-alert-to-pre-existing-sns-consolidated-acct
``` terraform
module "billing_cloudwatch_alert" {
  source = "billtrust/billing-alarm/aws"

  aws_env = "${var.aws_profile}"
  monthly_billing_threshold = 500
  currency = "USD"
}
```

---

### Important Considerations
* This metric is checked every 8 hours, and a single metric sample above the threshold amount will trigger an alarm state. The metric is named `billing-alarm-${lower(currency)}-${aws_env}`
* If `aws_sns_topic_enabled = true` the alarm action is automatically set to the created SNS topic, `billing-alarm-notification-${lower(currency)}-${aws_env}`. **YOU MUST MANUALLY SUBSCRIBE TO THIS SNS TOPIC.**

    !! MANUAL STEP :
    !! Subscribe emails to `arn:aws:sns:us-east-1:111111111111:billing-alarm-notification-usd-dev for billing alarms`