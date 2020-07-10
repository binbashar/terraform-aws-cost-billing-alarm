#
# Define some input just to show how variables can be passed from the test.
#
#variable "countries" {
#    description = "Countries"
#    default     = "AR,BR,CH"
#}

#
# Instantiate the module.
#
#module "backend" {
#    source      = "../../"
#    
#    countries   = "${var.countries}"
#}

#
# Output the module's output for verification.
#
#output "countries" {
#    value = "${module.sample.countries}"
#}

module "billing_cloudwatch_alert" {
  source = "../../"

  aws_env                   = var.profile
  monthly_billing_threshold = 500
  currency                  = "USD"
}

output "sns_topic" {
  value = module.billing_cloudwatch_alert.sns_topic_arn
}