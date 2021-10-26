output "sns_topic_arns" {
  description = "List of SNS Topic ARNs to be subscribed to in order to delivery the clodwatch billing alarms"
  value       = lookup(local.alarm, "alarm_actions")
}
