#=============================#
# AWS Provider Settings       #
#=============================#
provider "aws" {
  region                  = var.region
  profile                 = var.profile
  shared_credentials_file = "~/.aws/${var.project}/config"
}

variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "profile" {
  description = "AWS Profile"
  default     = "bb-dev-deploymaster"
}

# Uncomment for local testing
//variable "profile" {
//  description = "AWS Profile"
//  default     = "bb-apps-devstg-devops"
//}

#=============================#
# Backend Config (partial)    #
#=============================#
terraform {
  required_version = ">= 0.14.11"

  required_providers {
    aws = "~> 3.0"
  }

}

#=============================#
# Project Variables           #
#=============================#
variable "project" {
  description = "Project id"
  default     = "bb"
}

variable "environment" {
  description = "Environment Name"
  default     = "dev-test"
}
