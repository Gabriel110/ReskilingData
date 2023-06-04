variable "lamba_name" {
  type        = string
  description = ""
  default     = "lambda-process-gabriel"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "service_domain" {
  type        = string
  description = ""
  default     = "api"
}

variable "rds_name" {
  type        = string
  description = ""
  default     = "rds-gabriel"
}

variable "vpc_name" {
  type        = string
  description = ""
  default     = "vpc-zup-datadivision-training-dev"
}