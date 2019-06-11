module "billing_cloudwatch_alert" {
  source = "../../cost-mgmt-billing-alarm-bb"

  aws_env                   = "${var.aws_profile}"
  monthly_billing_threshold = 500
  currency                  = "USD"
}

output "sns_topic" {
  value = "${module.billing_cloudwatch_alert.sns_topic}"
}

# Will output the following:
# arn:aws:sns:us-east-1:111111111111:billing-alarm-notification-usd-dev

