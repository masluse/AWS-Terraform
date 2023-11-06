resource "aws_vpc" "default" {
  cidr_block       = var.cidr
  instance_tenancy = "default"
  tags = {
    Name = var.name
  }
}