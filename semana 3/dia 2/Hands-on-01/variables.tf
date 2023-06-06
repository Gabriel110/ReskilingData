variable "region" {
  type    = string
  default = "us-east-1"
}

variable "bucket_name" {
  type    = string
  default = "anime-bucket-122334"
}

variable "vpc_name" {
  type        = string
  description = ""
  default     = "vpc-zup-datadivision-training-dev"
}
