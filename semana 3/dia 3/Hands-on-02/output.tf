

output "bucket" {
  value = {
    arn  = aws_s3_bucket.my_protected_bucket.arn
    name = aws_s3_bucket.my_protected_bucket.id
  }
}
