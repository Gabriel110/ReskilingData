provider "aws" {
  region                      = var.region
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    lambda     = "http://localhost:4566"
    cloudwatch = "http://localhost:4566"
    iam        = "http://localhost:4566"
    sns        = "http://localhost:4566"
    sqs        = "http://localhost:4566"
  }
}

resource "aws_lambda_function" "lambda_function" {
  function_name    = var.lamba_name
  filename         = data.archive_file.lambda_zip_file.output_path
  source_code_hash = data.archive_file.lambda_zip_file.output_base64sha256
  handler          = "handler.handler"
  role             = aws_iam_role.lambda_assume_role.arn
  runtime          = "python3.8"

  lifecycle {
    create_before_destroy = true
  }
}

data "archive_file" "lambda_zip_file" {
  output_path = "${path.module}/lambda_zip/lambda.zip"
  source_dir  = "${path.module}/lambda"
  excludes    = ["__init__.py", "*.pyc"]
  type        = "zip"
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  event_source_arn  = aws_sqs_queue.queue.arn
  function_name     = aws_lambda_function.lambda_function.arn
  enabled           = true
  batch_size        = 1
  starting_position = "LATEST"
}