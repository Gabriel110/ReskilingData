resource "aws_secretsmanager_secret" "example" {
  name = var.secrets_name
}