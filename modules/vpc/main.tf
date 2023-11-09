# This resource creates a Virtual Private Cloud (VPC) which is a virtual network dedicated to your AWS account.
resource "aws_vpc" "default" {
  cidr_block       = var.cidr  # The CIDR block for the VPC, defining its IP address range.
  instance_tenancy = "default"  # The instance tenancy option for the VPC, which is 'default' here.

  tags = {
    Name = var.name  # Assigns a name tag to the VPC for identification purposes.
  }
}
