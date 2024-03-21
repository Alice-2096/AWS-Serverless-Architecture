terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "dynamodb_table" {
  source      = "./modules/Dynamo"
  environment = var.environment
}


