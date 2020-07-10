module "billing_cloudwatch_alert" {
  source = "../../../terraform-aws-cost-billing-alarm"

  aws_env                   = var.aws_profile
  aws_account_id            = 111111111111
  monthly_billing_threshold = 500
  currency                  = "USD"
}

output "sns_topic" {
  value = module.billing_cloudwatch_alert.sns_topic_arn
}

# Will output the following:
# arn:aws:sns:us-east-1:111111111111:billing-alarm-notification-usd-dev

