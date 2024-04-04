resource "aws_api_gateway_rest_api" "my_apigw" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "api-gateway"
      version = "1.0"
    }
    paths = {
      "${var.path}" = {
        post = { # use HTTP POST method to invoke the lambda function! 
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            payloadFormatVersion = "1.0"
            type                 = "AWS_PROXY"
            uri                  = var.lambda_invoke_arn
          }
        }
      }
    }
  })

  name = "my_apigw"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.my_apigw.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.my_apigw.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "gw_stage" {
  deployment_id = aws_api_gateway_deployment.gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.my_apigw.id
  stage_name    = "dev"
}

# add permission to lambda to permit API Gateway to invoke the lambda function
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.my_apigw.execution_arn}/*"
}

# create a custom domain name for the API Gateway in a specific region
resource "aws_api_gateway_domain_name" "gw_domain_name" {
  domain_name              = var.domain_name
  regional_certificate_arn = var.acm_certificate_arn

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_base_path_mapping" "gw_base_path_mapping" {
  api_id      = aws_api_gateway_rest_api.my_apigw.id
  domain_name = aws_api_gateway_domain_name.gw_domain_name.domain_name
  stage_name  = aws_api_gateway_stage.gw_stage.stage_name
}

# route traffic from domain to API gateway's regional domain 
resource "aws_route53_record" "record" {
  name    = var.domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.domain.zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_api_gateway_domain_name.gw_domain_name.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.gw_domain_name.regional_zone_id
  }
}
