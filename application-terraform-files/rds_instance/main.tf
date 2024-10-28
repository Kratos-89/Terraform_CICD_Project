variable "db_subnet_group_name"{}
variable "subnet_groups"{}
variable "mysql_db_identifier" {}
variable "mysql_username" {}
variable "mysql_password" {}
variable "rds_mysql_sg" {}
variable "mysql_dbname" {}


resource "aws_db_subnet_group" "subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_groups # replace with your private subnet IDs
}

resource "aws_db_instance" "rds_instance"{
  allocated_storage = 20
  storage_type = "gp3"
  engine = "mysql"
  engine_version = "5.7.44"
  instance_class = "db.t3.micro"
  identifier            = var.mysql_db_identifier
  username                = var.mysql_username
  password                = var.mysql_password
  vpc_security_group_ids = [var.rds_mysql_sg]
  db_name                 = var.mysql_dbname
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
  skip_final_snapshot     = true
  publicly_accessible  = false
  apply_immediately       = true
  backup_retention_period = 0
  deletion_protection     = false
}