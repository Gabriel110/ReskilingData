resource "aws_cloudwatch_log_group" "glue_logs_group" {
  name              = "glue-logs-group"
  retention_in_days = 14
}