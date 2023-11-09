locals {
  prv     = var.private == false ? true : ""
  pub     = var.private == true ? false : ""
  prv_pub = coalesce(local.prv, local.pub)
}

resource "aws_subnet" "default" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr
  map_public_ip_on_launch = local.prv_pub
  availability_zone = var.availability_zone
  tags = {
    Name = var.name
  }
}

resource "aws_internet_gateway" "nat_gateway" {
  count  = var.private == false ? 1 : 0
  vpc_id = var.vpc_id
  tags = {
    "Name" = var.name
  }
}

resource "aws_route_table" "nat_gateway" {
  count  = var.private == false ? 1 : 0
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nat_gateway[count.index].id
  }
}

resource "aws_route_table_association" "nat_gateway" {
  count          = var.private == false ? 1 : 0
  subnet_id      = aws_subnet.default.id
  route_table_id = aws_route_table.nat_gateway[count.index].id
}