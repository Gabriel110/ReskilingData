resource "aws_glue_catalog_database" "glue_database_anime" {
  name = "glue-database-animes"
  

  create_table_default_permission {
    permissions = ["SELECT", "ALTER", "DROP"]

    principal {
      data_lake_principal_identifier =  "IAM_ALLOWED_PRINCIPALS"
      #"arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/root"
    }
  }
}


resource "aws_glue_crawler" "crawler" {
  database_name = aws_glue_catalog_database.glue_database_anime.name
  name          = "glue-crawler-anime"
  role          = aws_iam_role.glue_role.arn
  s3_target {
    path = "s3://anime-bucket-122334/raw/"
  }
}

resource "aws_glue_job" "glue_job" {
  name     = "glue-job-anime"
  role_arn = aws_iam_role.glue_role.arn
  glue_version = "3.0"

  command {
    script_location = "s3://anime-bucket-122334/script/spark/processamento.py"
    python_version = "3"
  }

  default_arguments = {
    "--job-language" = "python"
    "--continuous-log-logGroup"          = aws_cloudwatch_log_group.glue_logs_group.name
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-continuous-log-filter"     = "true"
    "--enable-metrics"                   = ""
  }
}