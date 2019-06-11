provider "aws" {
  region  = "us-east-1"
  profile = "${var.aws_profile}"
}

variable "aws_profile" {
  value = "dev"
}
