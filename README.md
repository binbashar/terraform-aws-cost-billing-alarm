<a href="https://github.com/binbashar">
    <img src="https://raw.githubusercontent.com/binbashar/le-ref-architecture-doc/master/docs/assets/images/logos/binbash-leverage-banner.png" width="1032" align="left" alt="Binbash"/>
</a>
<br clear="left"/>

# AWS Billing Cloudwatch Alarm terraform module: terraform-aws-cost-mgmt-billing-alarm

Adds a billing alert with optional sns topic creation (or use a pre-existing one) to alert when a U$S (currency actually configurable) billing threshold is reached.

If `aws_sns_topic_enabled = true` then you'll still need to subscribe to the created SNS topic manually (please check **Important Consderations** section for detailed info).

## Releases
- **Versions:** `<= 0.x.y` (Terraform 0.11.x compatible)
    - eg: https://registry.terraform.io/modules/binbashar/cost-budget/aws/0.0.1

- **Versions:** `>= 1.x.y` (Terraform 0.12.x compatible -> **WIP**)
    - eg: https://registry.terraform.io/modules/binbashar/cost-budget/aws/1.0.0

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.28 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.70.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.account_billing_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_sns_topic.sns_alert_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | AWS account id | `string` | `null` | no |
| <a name="input_aws_env"></a> [aws\_env](#input\_aws\_env) | AWS environment you are deploying to. Will be appended to SNS topic and alarm name. (e.g. dev, stage, prod) | `string` | n/a | yes |
| <a name="input_create_sns_topic"></a> [create\_sns\_topic](#input\_create\_sns\_topic) | Creates a SNS Topic if `true`. | `bool` | `true` | no |
| <a name="input_currency"></a> [currency](#input\_currency) | Short notation for currency type (e.g. USD, CAD, EUR) | `string` | `"USD"` | no |
| <a name="input_monthly_billing_threshold"></a> [monthly\_billing\_threshold](#input\_monthly\_billing\_threshold) | The threshold for which estimated monthly charges will trigger the metric alarm. | `string` | n/a | yes |
| <a name="input_sns_topic_arns"></a> [sns\_topic\_arns](#input\_sns\_topic\_arns) | List of SNS topic ARNs to be used. If `create_sns_topic` is `true`, it merges the created SNS Topic by this module with this list of ARNs | `list(string)` | `[]` | no |
| <a name="input_datapoints_to_alarm"></a> [datapoints\_to\_alarm](#input\_datapoint\_to\_alarm) | The number of datapoints that must be breaching to trigger the alarm. | `number` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sns_topic_arns"></a> [sns\_topic\_arns](#output\_sns\_topic\_arns) | List of SNS Topic ARNs to be subscribed to in order to delivery the clodwatch billing alarms |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

The module outputs one block, sns_topic_arns. Access it like this:

```
output "sns_topic_arns" {
  value = module.billing_alert.sns_topic_arns
}
```

## Examples

### For an specific account
#### cloudwatch-billing-alert-to-new-sns-with-acct-id
```terraform
module "billing_alert" {
  source = "binbashar/cost-billing-alarm/aws"

  aws_env = "${var.aws_profile}"
  aws_account_id = 111111111111
  monthly_billing_threshold = 500
  currency = "USD"
}

output "sns_topic_arn" {
  value = "${module.billing_alert.sns_topic_arn}"
}
# Will output the following:
# arn:aws:sns:us-east-1:111111111111:billing-alarm-notification-usd-dev for billing alarms
```

#### cloudwatch-billing-alert-to-pre-existing-sns-with-acct-id
``` terraform
module "billing_cloudwatch_alert" {
  source = "binbashar/cost-billing-alarm/aws"

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
  source = "binbashar/cost-billing-alarm/aws"

  aws_env = "${var.aws_profile}"
  monthly_billing_threshold = 500
  currency = "USD"
}

output "sns_topic_arn" {
  value = "${module.billing_alert.sns_topic_arn}"
}
# Will output the following:
# arn:aws:sns:us-east-1:111111111111:billing-alarm-notification-usd-dev for billing alarms
```

#### cloudwatch-billing-alert-to-pre-existing-sns-consolidated-acct
``` terraform
module "billing_cloudwatch_alert" {
  source = "binbashar/cost-billing-alarm/aws"

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

## Binbash Leverage | DevOps Automation Code Library Integration

In order to get the full automated potential of the
[Binbash Leverage DevOps Automation Code Library](https://leverage.binbash.com.ar/how-it-works/code-library/code-library/)  
you should initialize all the necessary helper **Makefiles**.

#### How?
You must execute the `make init-makefiles` command  at the root context

```shell
╭─delivery at delivery-I7567 in ~/terraform/terraform-aws-backup-by-tags on master✔ 20-09-17
╰─⠠⠵ make
Available Commands:
 - init-makefiles     initialize makefiles

```

### Why?
You'll get all the necessary commands to automatically operate this module via a dockerized approach,
example shown below

```shell
╭─delivery at delivery-I7567 in ~/terraform/terraform-aws-backup-by-tags on master✔ 20-09-17
╰─⠠⠵ make
Available Commands:
 - circleci-validate-config  ## Validate A CircleCI Config (https
 - format-check        ## The terraform fmt is used to rewrite tf conf files to a canonical format and style.
 - format              ## The terraform fmt is used to rewrite tf conf files to a canonical format and style.
 - tf-dir-chmod        ## run chown in ./.terraform to gran that the docker mounted dir has the right permissions
 - version             ## Show terraform version
 - init-makefiles      ## initialize makefiles
```

```shell
╭─delivery at delivery-I7567 in ~/terraform/terraform-aws-backup-by-tags on master✔ 20-09-17
╰─⠠⠵ make format-check
docker run --rm -v /home/delivery/Binbash/repos/Leverage/terraform/terraform-aws-backup-by-tags:"/go/src/project/":rw -v :/config -v /common.config:/common-config/common.config -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/etc/gitconfig -v ~/.aws/bb:/root/.aws/bb -e AWS_SHARED_CREDENTIALS_FILE=/root/.aws/bb/credentials -e AWS_CONFIG_FILE=/root/.aws/bb/config --entrypoint=/bin/terraform -w "/go/src/project/" -it binbash/terraform-awscli-slim:0.12.28 fmt -check
```

 # Release Management

### CircleCi PR auto-release job

<div align="left">
  <img src="https://raw.githubusercontent.com/binbashar/terraform-aws-cost-billing-alarm/master/figures/circleci.png"
   alt="leverage-circleci" width="130"/>
</div>

- [**pipeline-job**](https://circleci.com/gh/binbashar/terraform-aws-cost-billing-alarm) (**NOTE:** Will only run after merged PR)
- [**releases**](https://github.com/binbashar/terraform-aws-cost-billing-alarm/releases)
- [**changelog**](https://github.com/binbashar/terraform-aws-cost-billing-alarm/blob/master/CHANGELOG.md)
