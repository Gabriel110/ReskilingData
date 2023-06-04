# Output do projeto
output "lambda" {
  value = {
    arn        = aws_lambda_function.lambda_function.arn
    name       = aws_lambda_function.lambda_function.function_name
    invoke_arn = aws_lambda_function.lambda_function.invoke_arn
  }
}