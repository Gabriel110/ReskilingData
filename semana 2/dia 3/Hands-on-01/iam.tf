resource "aws_iam_role" "lambda_assume_role" {
  name               = "lambda-process-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
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


data "aws_iam_policy_document" "queue_policy" {
  statement {
    sid    = "First"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.queue.arn]

    # condition {
    #   test     = "ArnEquals"
    #   variable = "aws:SourceArn"
    #   values   = [aws_sns_topic.example.arn]
    # }
  }
}

resource "aws_sqs_queue_policy" "test" {
  queue_url = aws_sqs_queue.queue.id
  policy    = data.aws_iam_policy_document.queue_policy.json
}