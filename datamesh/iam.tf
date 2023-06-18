###GLUE PERMISSION
data "aws_iam_policy_document" "glue_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "glue_action" {
  statement {
    sid    = "AllowS3AndGLUEActions"
    effect = "Allow"
    resources = [
      "arn:aws:s3:::anime-bucket-122334/*"
    ]

    actions = [
      "s3:*",
      "glue:*",
      "logs:*"
    ]
  }
}

resource "aws_iam_role" "glue_role" {
  name               = "glue-role"
  assume_role_policy = data.aws_iam_policy_document.glue_policy.json
}

resource "aws_iam_policy" "glue_policy" {
  name   = "glue-execute-policy"
  policy = data.aws_iam_policy_document.glue_action.json
}

resource "aws_iam_role_policy_attachment" "glue_service" {
  role       = aws_iam_role.glue_role.name
  policy_arn = aws_iam_policy.glue_policy.arn
}

resource "aws_iam_role_policy_attachment" "glue_service_role" {
  role       = aws_iam_role.glue_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_role_policy_attachment" "glue_full_console_access" {
  role       = aws_iam_role.glue_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess"
}


###S3 Permitions

resource "aws_iam_role_policy_attachment" "amazon_s3_full_access" {
  role       = aws_iam_role.glue_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
