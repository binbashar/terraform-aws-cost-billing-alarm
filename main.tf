#
# case 1
# if(var.aws_sns_topic_arn != "" && var.aws_account_id != "")
#
resource "aws_cloudwatch_metric_alarm" "account_billing_alarm_to_existing_sns" {
  count               = "${var.aws_sns_topic_arn != "" && var.aws_account_id != "" ? 1 : 0}"
  alarm_name          = "account-billing-alarm-${lower(var.currency)}-${var.aws_env}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "28800"
  statistic           = "Maximum"
  alarm_description   = "Billing alarm account ${var.aws_account_id} >= US$ ${var.monthly_billing_threshold}"
  threshold           = "${var.monthly_billing_threshold}"
  alarm_actions       = ["${var.aws_sns_topic_arn}"]

  dimensions = {
    Currency      = "${var.currency}"
    LinkedAccount = "${var.aws_account_id}"
  }

  tags = "${var.tags}"
}

#
# case 2
# if(var.aws_sns_topic_arn != "" && var.aws_account_id == "")
#
resource "aws_cloudwatch_metric_alarm" "consolidated_accounts_billing_alarm_to_existing_sns" {
  count               = "${var.aws_sns_topic_arn != "" && var.aws_account_id == "" ? 1 : 0}"
  alarm_name          = "account-billing-alarm-${lower(var.currency)}-${var.aws_env}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "28800"
  statistic           = "Maximum"
  alarm_description   = "Billing consolidated alarm >= US$ ${var.monthly_billing_threshold}"
  threshold           = "${var.monthly_billing_threshold}"
  alarm_actions       = ["${var.aws_sns_topic_arn}"]

  dimensions = {
    Currency = "${var.currency}"
  }

  tags = "${var.tags}"
}

#
# cases 3 & 4
# if(var.aws_sns_topic_arn == "")
#
resource "aws_sns_topic" "sns_alert_topic" {
  count = "${var.aws_sns_topic_arn == "" ? 1 : 0}"
  name  = "billing-alarm-notification-${lower(var.currency)}-${var.aws_env}"

  tags = "${var.tags}"
}

#
# case 3
# if(var.aws_sns_topic_arn == "" && var.aws_account_id != "")
#
resource "aws_cloudwatch_metric_alarm" "account_billing_alarm_to_new_sns" {
  count               = "${var.aws_sns_topic_arn == "" && var.aws_account_id != "" ? 1 : 0}"
  alarm_name          = "account-billing-alarm-${lower(var.currency)}-${var.aws_env}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "28800"
  statistic           = "Maximum"
  alarm_description   = "Billing alarm account ${var.aws_account_id} >= US$ ${var.monthly_billing_threshold}"
  threshold           = "${var.monthly_billing_threshold}"
  alarm_actions       = ["${aws_sns_topic.sns_alert_topic.arn}"]

  dimensions = {
    Currency      = "${var.currency}"
    LinkedAccount = "${var.aws_account_id}"
  }

  tags = "${var.tags}"
}

#
# case 4
# if(var.aws_sns_topic_arn == "" && var.aws_account_id == "")
#
resource "aws_cloudwatch_metric_alarm" "consolidated_accounts_billing_alarm_to_new_sns" {
  count               = "${var.aws_sns_topic_arn == "" && var.aws_account_id == "" ? 1 : 0}"
  alarm_name          = "account-billing-alarm-${lower(var.currency)}-${var.aws_env}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "28800"
  statistic           = "Maximum"
  alarm_description   = "Billing consolidated alarm >= US$ ${var.monthly_billing_threshold}"
  threshold           = "${var.monthly_billing_threshold}"
  alarm_actions       = ["${aws_sns_topic.sns_alert_topic.arn}"]

  dimensions = {
    Currency = "${var.currency}"
  }

  tags = "${var.tags}"
}
