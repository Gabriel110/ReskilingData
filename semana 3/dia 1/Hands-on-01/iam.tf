data "aws_iam_policy_document" "role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_action" {
  statement {
    sid       = "AllowS3AndSNSActions"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "s3:*",
      "sns:*",
    ]
  }
  statement {
    sid       = "AllowInvokingLambdas"
    effect    = "Allow"
    resources = ["arn:aws:lambda:*:*:function:*"]
    actions   = ["lambda:InvokeFunction"]
  }

  statement {
    sid       = "AllowCreatingLogGroups"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:*"]
    actions   = ["logs:CreateLogGroup"]
  }

  statement {
    sid       = "AllowWritingLogs"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/*:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

resource "aws_iam_role" "lambda-assume-role" {
  name               = "${var.service_domain}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.role.json
}


resource "aws_iam_policy" "s3" {
  name   = "${aws_lambda_function.lambda_function.function_name}-lambda-execute-policy"
  policy = data.aws_iam_policy_document.lambda_action.json
}

resource "aws_iam_role_policy_attachment" "s3-execute" {
  policy_arn = aws_iam_policy.s3.arn
  role       = aws_iam_role.lambda-assume-role.name
}