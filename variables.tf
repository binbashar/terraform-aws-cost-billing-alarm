#=============================#
# Cloudwatch Billing alert    #
#=============================#
variable "aws_env" {
  description = "AWS environment you are deploying to. Will be appended to SNS topic and alarm name. (e.g. dev, stage, prod)"
  type        = string
}

variable "monthly_billing_threshold" {
  description = "The threshold for which estimated monthly charges will trigger the metric alarm."
  type        = string
}

variable "currency" {
  description = "Short notation for currency type (e.g. USD, CAD, EUR)"
  type        = string
  default     = "USD"
}

variable "aws_account_id" {
  description = "AWS account id"
  type        = string
  default     = ""
}

#=============================#
# SNS                         #
#=============================#
variable "aws_sns_topic_arn" {
  description = "If aws_sns_topic_enabled = false, then an existing AWS SNS topic ARN for the billing alert integration will be used"
  type        = string
  default     = ""
}

#=============================#
# TAGS                        #
#=============================#
variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to all resources"
  default     = {}
}
