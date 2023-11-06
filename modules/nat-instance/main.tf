resource "aws_eip" "nat" {
  vpc = true
  tags = {
    "Name" = var.name
  }
}

resource "aws_nat_gateway" "default" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.subnet_id_place

  tags = {
    Name = var.name
  }
  depends_on = [
    resource.aws_eip.nat
  ]
}

resource "aws_route_table" "instance" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.default.id
  }
}

resource "aws_route_table_association" "instance" {
  subnet_id = var.subnet_id_route
  route_table_id = aws_route_table.instance.id
}