# Building a Serverless Application with API Gateway, Lambda, and Cognito
This example demonstrates how to create an end-to-end AWS API Gateway REST API setup with an OpenAPI configuration that proxies the AWS IP Address Ranges JSON, enables CloudWatch metrics, and sets up a domain with a self-signed TLS certificate to mimic a real-world endpoint. The outputs will provide sample curl commands to verify the REST API deployment.


## Running this Example
Terraform variables are available to modify this example, see the variables.tf file. They can be provided by cp terraform.template.tfvars terraform.tfvars, modifying terraform.tfvars with your variables, and running terraform apply. Alternatively, the variables can be provided as flags by running:
terraform apply --auto-approve -var="region=us-east-1" -var="domain_name=<replace-with-your-domain-name>" 

