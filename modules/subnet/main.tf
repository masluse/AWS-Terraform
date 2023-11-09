# Resource for an AWS subnet, potentially with automatic public IP assignment based on the 'prv_pub' local variable.
resource "aws_subnet" "default" {
  vpc_id                  = var.vpc_id              # The ID of the VPC for subnet creation, passed as a variable.
  cidr_block              = var.cidr                # The CIDR block for the subnet, passed as a variable.
  map_public_ip_on_launch = local.prv_pub           # Determines if public IP is automatically assigned, based on 'prv_pub'.
  availability_zone       = var.availability_zone   # The availability zone where the subnet will be created, passed as a variable.
  tags = {
    Name = var.name                                 # Tags the subnet with a name, passed as a variable.
  }
}

# Internet Gateway resource, conditionally created based on the 'private' variable.
resource "aws_internet_gateway" "nat_gateway" {
  count  = var.private == false ? 1 : 0             # Creates an internet gateway only if 'private' is false.
  vpc_id = var.vpc_id                               # Associates the gateway with the specified VPC.
  tags = {
    "Name" = var.name                               # Tags the internet gateway with a name.
  }
}

# Route table for the NAT Gateway, conditionally created to route traffic from the subnet to the internet.
resource "aws_route_table" "nat_gateway" {
  count  = var.private == false ? 1 : 0             # Creates a route table only if 'private' is false.
  vpc_id = var.vpc_id                               # Associates the route table with the specified VPC.
  route {
    cidr_block = "0.0.0.0/0"                        # Default route for all outbound traffic.
    gateway_id = aws_internet_gateway.nat_gateway[count.index].id # The ID of the internet gateway to route through.
  }
}

# Association between the subnet and NAT Gateway's route table.
resource "aws_route_table_association" "nat_gateway" {
  count          = var.private == false ? 1 : 0     # Associates only if 'private' is false.
  subnet_id      = aws_subnet.default.id            # The subnet to associate with the route table.
  route_table_id = aws_route_table.nat_gateway[count.index].id # The route table to associate.
}
