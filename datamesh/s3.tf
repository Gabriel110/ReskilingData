resource "random_pet" "bucket" {}

resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket_name
  force_destroy = true
}

resource "aws_s3_object" "anime" {
  bucket       = aws_s3_bucket.bucket.id
  key          = "raw/anime/anime.csv"
  content_type = "text/markdown; charset=UTF-8"
  source       = local.anime_file_path
  etag         = filemd5(local.anime_file_path)
}

resource "aws_s3_object" "rating" {
  bucket       = aws_s3_bucket.bucket.id
  key          = "raw/rating/rating.csv"
  content_type = "text/markdown; charset=UTF-8"
  source       = local.rating_file_path
  etag         = filemd5(local.rating_file_path)
}


resource "aws_s3_object" "spark" {
  bucket       = aws_s3_bucket.bucket.id
  key          = "script/spark/processamento.py"
  content_type = "text/markdown; charset=UTF-8"
  source       = local.script_file_path
  etag         = filemd5(local.script_file_path)
}



resource "aws_s3_object" "processed" {
  bucket       = aws_s3_bucket.bucket.id
  key          = "processed/"
  content_type = "text/markdown; charset=UTF-8"
}