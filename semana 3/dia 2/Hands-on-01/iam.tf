resource "aws_iam_role" "glue" {
  name               = "AWSGlueServiceRoleDefault"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "glue_service" {
  role       = aws_iam_role.glue.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

## If you don't already have a policy, uncomment this section
resource "aws_iam_role_policy" "my_s3_policy" {
  name   = "my_s3_policy"
  role   = aws_iam_role.glue.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "glue:*",
        "s3:*",
        "ec2:*",
        "iam:*",
        "lakeformation:*",
        "cloudwatch:*"
      ],
      "Resource": [
        "arn:aws:s3:::anime-bucket-122334",
        "arn:aws:s3:::anime-bucket-122334/*"
      ]
    }
  ]
}
EOF
}


resource "aws_iam_role_policy" "glue_service_s3" {
  name   = "glue_service_s3"
  role   = aws_iam_role.glue.id
  policy = aws_iam_role_policy.my_s3_policy.policy
}