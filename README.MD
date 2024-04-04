# Building a Serverless Application with API Gateway, Lambda, and Cognito
This example demonstrates how to create an AWS API Gateway REST API that routes traffic to Lambda functions that handle the requests. In this example, we set up a domain with a self-signed TLS certificate to mimic a real-world endpoint. The outputs will provide sample curl commands to verify the REST API deployment.


## Running this Example
Create a terraform.tfvars file to set values for the required variables. Then run terraform apply. Alternatively, you can provide variables as flags by running:
terraform apply --auto-approve -var="region=us-east-1" -var="domain_name=<replace-with-your-domain-name>" -var="path=<path>" -var="environment=<env>"

