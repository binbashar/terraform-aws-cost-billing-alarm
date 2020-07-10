#
# Billing SNS
#
output "budget_sns_topic_arn" {
  description = "SNS Topic ARN to be subscribed to in order to delivery the budget billing notifications"
  value       = module.billing_cloudwatch_alert.sns_topic_arn
}
