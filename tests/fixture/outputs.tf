#
# Billing SNS
#
output "budget_sns_topic_arn" {
  description = "List of SNS Topic ARNs to be subscribed to in order to delivery the budget billing notifications"
  value       = module.billing_cloudwatch_alert.sns_topic_arns
}
