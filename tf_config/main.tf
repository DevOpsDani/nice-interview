terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.25.0"
    }
  }
  required_version = ">= 1.6.4"
}

provider "aws" {
  region  = "us-east-1"
  profile = "daniel-interview"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "lambda" {
  source = "./modules/lambda"
}

module "s3" {
  source = "./modules/s3"

  lambda_arn = module.lambda.lambda_arn
  depends_on = [module.lambda]
}