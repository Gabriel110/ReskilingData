provider "aws" {
  region                      = var.region
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    lambda     = var.default_endpoint
    cloudwatch = var.default_endpoint
    iam        = var.default_endpoint
    sns        = var.default_endpoint
    sqs        = var.default_endpoint
    dynamodb   = var.default_endpoint
    apigateway = var.default_endpoint
  }
}