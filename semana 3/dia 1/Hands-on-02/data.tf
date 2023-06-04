data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}

data "aws_vpc" "targetVpc" {
  #id = "${var.vpc_id}"
  filter {
    name   = "tag-value"
    values = ["${var.vpc_name}"]
  }
  filter {
    name   = "tag-key"
    values = ["Name"]
  }
}

data "aws_rds_engine_version" "postgresql" {
  engine  = "aurora-postgresql"
  version = "14.5"
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.targetVpc.id
}


data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = ["${data.aws_vpc.targetVpc.id}"]
  }
}

data "aws_subnet" "subnet" {
  for_each = toset(data.aws_subnets.subnets.ids)
  id       = each.value
}