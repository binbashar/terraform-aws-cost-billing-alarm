locals {
  tags = {
    Name        = "infra-cost-billing-sns-test"
    Terraform   = "true"
    Environment = var.environment
  }
}
