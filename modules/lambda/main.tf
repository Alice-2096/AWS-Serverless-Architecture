# store package locally, no lambda layers for now 
module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.2.2"

  function_name = "my-lamda-1"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"

  source_path = "./lambda/index.py"

  tags = {
    Name = "my-lambda-1"
  }

  # attach policy to the Lambda Function to allow access to DB and CloudWatch
  attach_policies = true
  policies = ["arn:aws:iam::aws:policy/service-role/AWSLambdaDynamoDBExecutionRole",
  "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
}

