resource "aws_sqs_queue" "queue" {
  name                      = var.sqs_name
  receive_wait_time_seconds = 20
  message_retention_seconds = 18400

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.queue_dlq.arn
    maxReceiveCount     = 4
  })
}

resource "aws_sqs_queue" "queue_dlq" {
  name                      = "${var.sqs_name}_dlq"
  message_retention_seconds = 18400
}