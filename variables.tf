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
  default     = null
}

variable "datapoints_to_alarm" {
  description = "The number of datapoints that must be breaching to trigger the alarm."
  type        = number
  default     = null
}

#=============================#
# SNS                         #
#=============================#
variable "create_sns_topic" {
  description = "Creates a SNS Topic if `true`."
  type        = bool
  default     = true
}


variable "sns_topic_arns" {
  description = "List of SNS topic ARNs to be used. If `create_sns_topic` is `true`, it merges the created SNS Topic by this module with this list of ARNs"
  type        = list(string)
  default     = []
}

#=============================#
# TAGS                        #
#=============================#
variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to all resources"
  default     = {}
}
