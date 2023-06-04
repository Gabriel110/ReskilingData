# resource "aws_db_instance" "may_db" {
#   identifier           = var.rds_name
#   allocated_storage    = 10
#   db_name              = "gabriel1996"
#   engine               = "mysql"
#   engine_version       = "5.7"
#   instance_class       = "db.t2.micro"
#   username             = "foo"
#   password             = "foobarbaz"
#   skip_final_snapshot  = true
#   db_subnet_group_name = aws_db_subnet_group.subnet_group_name.id
# }

# resource "aws_db_subnet_group" "subnet_group_name" {
#   name       = "dbsubnet"
#   subnet_ids = [for subnet in data.aws_subnet.subnet : subnet.id]
# }


# module "cluster" {
#   source  = "terraform-aws-modules/rds-aurora/aws"

#   name           = "aurora-db-postgres-gabriel"
#   engine         = "aurora-postgresql"
#   engine_version = "14.5"
#   instance_class = "db.r6g.large"
#   master_username = "gabriel"
#   master_password = "1234567890"
#   instances = {
#     one = {instance_class = "db.r6g.2xlarge"}
#   }

#   vpc_id               = data.aws_vpc.targetVpc.id
#   db_subnet_group_name = aws_db_subnet_group.subnet_group_name.id
#   security_group_rules = {
#     ex1_ingress = {
#       cidr_blocks = ["10.20.0.0/20"]
#     }
#     ex1_ingress = {
#       source_security_group_id = data.aws_security_group.default.id
#     }
#   }

#   skip_final_snapshot = true
#   storage_encrypted   = true
#   apply_immediately   = true
#   monitoring_interval = 10

#   enabled_cloudwatch_logs_exports = ["postgresql"]

#   tags = {
#     Environment = "dev"
#     Terraform   = "true"
#   }
# }

resource "aws_db_subnet_group" "subnet_group_name" {
  name       = "dbsubnet"
  subnet_ids = [for subnet in data.aws_subnet.subnet : subnet.id]
}


module "aurora_postgresql_v2" {
  source = "terraform-aws-modules/rds-aurora/aws"

  name              = "gabrielpostgresqlv2"
  database_name     = "gabrielpostgresqlv2" 
  engine            = data.aws_rds_engine_version.postgresql.engine
  engine_mode       = "provisioned"
  engine_version    = data.aws_rds_engine_version.postgresql.version
  storage_encrypted = true
  master_username   = "root"

  vpc_id               = data.aws_vpc.targetVpc.id
  db_subnet_group_name = aws_db_subnet_group.subnet_group_name.id
  security_group_rules = {
    vpc_ingress = {
      cidr_blocks = [local.vpc_cidr]
    }
  }

  monitoring_interval = 60

  apply_immediately   = true
  skip_final_snapshot = true

  serverlessv2_scaling_configuration = {
    min_capacity = 2
    max_capacity = 10
  }

  instance_class = "db.serverless"
  instances = {
    one = {}
  }

  tags = local.tags
}

