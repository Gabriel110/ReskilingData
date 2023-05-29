# Output do projeto
output "sqs_arn" {
  value = aws_sqs_queue.queue.arn
}
