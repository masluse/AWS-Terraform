resource "aws_db_instance" "default" {
  allocated_storage    = var.storage
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  skip_final_snapshot  = true
  vpc_security_group_ids = [var.vpc_security_group_ids]
  db_subnet_group_name = var.db_subnet_group_name
}