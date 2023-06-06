resource "aws_glue_crawler" "crawler" {
  database_name = "glue_database_anime"
  name          = "glue_crawler_anime"
  role          = aws_iam_role.glue.arn
  s3_target {
    path = "s3://anime-bucket-122334/raw/"
  }
}