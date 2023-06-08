variable "region" {
  type    = string
  default = "us-east-1"
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "my-awesome-protected-s3-bucket-12234455"
}

variable "access_logging_bucket_name" {
  description = "S3 bucket name for access logging storage"
  type        = string
  default     = "my-access-logging-bucket-name"
}