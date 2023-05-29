resource "aws_iam_role" "lambda_assume_role" {
  name               = "lambda-dynamodb-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "*",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "LambdaAssumeRole"
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "writepolicy" {
  statement {
    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:GetRecords",
      "dynamodb:ListTables",
      "dynamodb:PutItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:UpdateItem",
      "dynamodb:UpdateTable",
    ]

    resources = [
      "${aws_dynamodb_table.dynamodb_table.arn}",
      "${aws_dynamodb_table.dynamodb_table.arn}/*"
    ]

    effect = "Allow"
  }
}

resource "aws_iam_policy" "writepolicy" {
  name   = "DynamoDb-Write-Policy"
  policy = "${data.aws_iam_policy_document.writepolicy.json}"
}


resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.lambda_input.execution_arn}/*/*"
}