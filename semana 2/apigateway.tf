
resource "aws_api_gateway_rest_api" "lambda_input" {
  name = var.api_name
}

resource "aws_api_gateway_resource" "lambda_input_resource" {
  rest_api_id   = aws_api_gateway_rest_api.lambda_input.id
  parent_id     = aws_api_gateway_rest_api.lambda_input.root_resource_id
  path_part = "api"  
}

resource "aws_api_gateway_method" "lambda_input_method" {
  rest_api_id   = aws_api_gateway_rest_api.lambda_input.id
  resource_id   = aws_api_gateway_resource.lambda_input_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lamba_integration" {
  rest_api_id             = aws_api_gateway_rest_api.lambda_input.id
  resource_id             = aws_api_gateway_resource.lambda_input_resource.id
  http_method             = aws_api_gateway_method.lambda_input_method.http_method 
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_function.invoke_arn 
}

resource "aws_api_gateway_deployment" "lambda_agw_deploy" {
  depends_on  = [ aws_api_gateway_integration.lamba_integration ]
  rest_api_id = aws_api_gateway_rest_api.lambda_input.id
  stage_name  = "dev"
}