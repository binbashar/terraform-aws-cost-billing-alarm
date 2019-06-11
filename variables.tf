#=============================#
# Cloudwatch Billing alert    #
#=============================#
variable "aws_env" {
  description = "AWS environment you are deploying to. Will be appended to SNS topic and alarm name. (e.g. dev, stage, prod)"
}

variable "monthly_billing_threshold" {
  description = "The threshold for which estimated monthly charges will trigger the metric alarm."
}

variable "currency" {
  description = "Short notation for currency type (e.g. USD, CAD, EUR)"
  default     = "USD"
}

variable "aws_account_id" {
  description = "AWS account id"
  default     = ""
}

#=============================#
# SNS                         #
#=============================#
variable "aws_sns_topic_arn" {
  description = "If aws_sns_topic_enabled = false, then an existing AWS SNS topic ARN for the billing alert integration will be used"
  default     = ""
}

#=============================#
# TAGS                        #
#=============================#
variable "tags" {
  type        = "map"
  description = "A mapping of tags to assign to all resources"
  default     = {}
}
