variable "lamba_name" {
  type = string
  description = ""
  default = "lambda-process"
}

variable "sns_name" {
  type = string
  description = ""
  default = "sns-lambda"
}

variable "sqs_name" {
  type = string
  description = ""
  default = "sqs-lambda"
}

variable "region" {
  type    = string
  default = "us-east-1"
}