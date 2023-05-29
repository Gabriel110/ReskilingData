variable "lamba_name" {
  type = string
  description = ""
  default = "lambda-process"
}

variable "sqs_name" {
  type = string
  description = ""
  default = "sqs-lambda"
}

variable "api_name" {
  type    = string
  default = "lambda-input-rest"
}

variable "default_endpoint" {
  description = "Endpoint padrão para os serviços AWS local."
  default     = "http://localhost:4566"
  type        = string
}


variable "region" {
  type    = string
  default = "us-east-1"
}
