variable "region" {
  type    = string
  default = "us-east-1"
}

variable "bucket_name" {
  type    = string
  default = "anime-bucket-122334"
}

variable "glue_name_crawler" {
  type = string
  default = "glue-crawler-anime"
}

variable "glue_name_database" {
  type = string
  default = "glue-database-animes"
}

variable "glue_name_job" {
  type = string
  default = "glue-job-anime"
}