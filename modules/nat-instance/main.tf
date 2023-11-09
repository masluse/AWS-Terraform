# This resource creates an Elastic IP (EIP) which is a static, public IP address designed for dynamic cloud computing.
resource "aws_eip" "nat" {
  tags = {
    "Name" = var.name  # Assigns a name tag to the EIP for identification purposes.
  }
}

# This resource deploys a NAT Gateway, which allows instances in a private subnet to access the internet or other AWS services.
resource "aws_nat_gateway" "default" {
  allocation_id = aws_eip.nat.id  # The EIP ID that the NAT gateway will be associated with.
  subnet_id     = var.subnet_id_place  # The ID of the subnet in which the NAT gateway is placed.

  tags = {
    Name = var.name  # Tags the NAT Gateway with a name for easier management.
  }
  depends_on = [
    aws_eip.nat  # Ensures the EIP is created before the NAT gateway.
  ]
}

# Creates a route table for a VPC with a route that directs traffic to the NAT Gateway.
resource "aws_route_table" "instance" {
  vpc_id = var.vpc_id  # The ID of the VPC for the route table.

  route {
    cidr_block     = "0.0.0.0/0"          # Represents all IPv4 addresses.
    nat_gateway_id = aws_nat_gateway.default.id  # The route table will use the NAT Gateway.
  }
}

# Associates a subnet with the created route table.
resource "aws_route_table_association" "instance" {
  subnet_id      = var.subnet_id_route  # The ID of the subnet to associate with the route table.
  route_table_id = aws_route_table.instance.id  # The ID of the route table.
}
