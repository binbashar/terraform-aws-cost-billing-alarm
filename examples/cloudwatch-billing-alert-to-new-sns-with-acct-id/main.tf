module "billing_cloudwatch_alert" {
  source = "../../../terraform-aws-cost-billing-alarm"

  aws_env                   = var.aws_profile
  aws_account_id            = 111111111111
  monthly_billing_threshold = 500
  currency                  = "USD"
}

output "sns_topics" {
  value = module.billing_cloudwatch_alert.sns_topic_arns
}

# Will output the following:
# [arn:aws:sns:us-east-1:111111111111:billing-alarm-notification-usd-dev]

