resource "aws_kms_key" "kms_s3_key" {
  description             = "key to protect s3 object"
  key_usage               = "ENCRYPT_DECRYPT"
  deletion_window_in_days = 7
  is_enabled              = true
}

resource "aws_kms_alias" "kms_s3_key_alias" {
  name = "alias/s3-ky"
  target_key_id = aws_kms_key.kms_s3_key.id
}