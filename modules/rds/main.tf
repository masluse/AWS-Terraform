# Defines a DB subnet group for RDS to use within specified subnets.
resource "aws_db_subnet_group" "default" {
  name       = "db_subnet_group"       # The name for the DB subnet group.
  subnet_ids = var.subnet_ids          # The list of subnet IDs to include in the subnet group.
}

# Resource definition for an RDS DB instance.
resource "aws_db_instance" "default" {
  allocated_storage    = var.storage              # The amount of storage allocated to the RDS instance.
  db_name              = var.db_name              # The name of the database to create when the DB instance is created.
  engine               = var.engine               # The database engine type (e.g., MySQL, PostgreSQL).
  engine_version       = var.engine_version       # The version of the database engine.
  instance_class       = var.instance_class       # The compute and memory capacity of the DB instance.
  username             = var.username             # Username for the master DB user.
  password             = var.password             # Password for the master DB user.
  skip_final_snapshot  = true                     # Determines whether a final DB snapshot is created upon deletion.
  vpc_security_group_ids = [var.vpc_security_group_ids]  # The security group IDs to associate with the RDS instance.
  db_subnet_group_name = aws_db_subnet_group.default.name  # The DB subnet group name for the RDS instance.
  depends_on             = [aws_db_subnet_group.default]  # Ensures that the RDS instance is created after the DB subnet group.
}
