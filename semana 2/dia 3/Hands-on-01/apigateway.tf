resource "aws_api_gateway_rest_api" "lambda_input_rest" {
  name = var.api_name
}

resource "aws_api_gateway_resource" "lambda_input_resource_rest" {
  rest_api_id = aws_api_gateway_rest_api.lambda_input_rest.id
  parent_id   = aws_api_gateway_rest_api.lambda_input_rest.root_resource_id
  path_part   = "sqs" 
}

resource "aws_api_gateway_method" "lambda_input_method_rest" {
  rest_api_id   = aws_api_gateway_rest_api.lambda_input_rest.id
  resource_id   = aws_api_gateway_resource.lambda_input_resource_rest.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_lamba_integration_rest" {
  rest_api_id   = aws_api_gateway_rest_api.lambda_input_rest.id
  resource_id   = aws_api_gateway_resource.lambda_input_resource_rest.id
  http_method   = aws_api_gateway_method.lambda_input_method_rest.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_function.invoke_arn 
}

resource "aws_api_gateway_deployment" "lambda_agw_deploy" {
  depends_on  = [ 
    aws_api_gateway_integration.lambda_lamba_integration_rest
  ]
  rest_api_id = aws_api_gateway_rest_api.lambda_input_rest.id
  stage_name  = "local"
}