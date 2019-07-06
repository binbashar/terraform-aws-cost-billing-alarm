module "billing_cloudwatch_alert" {
  source = "../../../terraform-aws-cost-billing-alarm"

  aws_env                   = "${var.aws_profile}"
  monthly_billing_threshold = 500
  currency                  = "USD"
  aws_sns_topic_arn         = "arn:aws:lambda:us-east-1:111111111111:function:bb-root-org-notify_slack"
}

output "sns_topic" {
  value = "${module.billing_cloudwatch_alert.sns_topic_arn}"
}

# Will output the following:
# arn:aws:lambda:us-east-1:111111111111:function:bb-root-org-notify_slack

