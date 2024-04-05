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
  source         = "./modules/Dynamo"
  environment    = var.environment
  table_name     = var.table_name
  write_capacity = 3
}

module "lambda" {
  source     = "./modules/lambda"
  region     = var.region
  table_name = var.table_name
}

module "acm_tsl" {
  source      = "./modules/acm_tls"
  domain_name = var.domain_name
}

module "api_gateway" {
  depends_on          = [module.acm_tsl]
  source              = "./modules/API Gateway"
  region              = var.region
  lambda_invoke_arn   = module.lambda.lambda_invoke_arn
  function_name       = module.lambda.function_name
  domain_name         = var.domain_name
  path                = var.path
  acm_certificate_arn = module.acm_tsl.acm_certificate_arn
}


