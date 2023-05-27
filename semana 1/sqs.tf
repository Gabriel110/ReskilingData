resource "aws_sqs_queue" "queue" {
  name                      = var.sqs_name
  receive_wait_time_seconds = 20
  message_retention_seconds = 18400
}

resource "aws_sns_topic_subscription" "queue_subscription" {
  protocol             = "sqs"
  raw_message_delivery = true
  topic_arn            = aws_sns_topic.sns_topic.arn
  endpoint             = aws_sqs_queue.queue.arn
}