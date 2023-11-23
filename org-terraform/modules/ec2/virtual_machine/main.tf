# Defines a network interface resource to be attached to an AWS instance.
resource "aws_network_interface" "default" {
  subnet_id       = var.subnet_id            # Subnet ID for the network interface
  security_groups = [var.security_groups]    # Security group IDs associated with the network interface
}

# Resource definition for an AWS EC2 instance.
resource "aws_instance" "default" {
  ami             = var.image                   # Amazon Machine Image (AMI) ID
  instance_type   = var.type                    # Type of EC2 instance
  key_name        = var.key_pair                # Key pair name for SSH access
  tags = {
    Name = var.name                            # Name tag for the instance
  }

  root_block_device {
    volume_size = var.disk_size                 # Size of the root volume
    volume_type = var.disk_type                 # Type of the root volume
  }

  network_interface {
    network_interface_id = aws_network_interface.default.id  # Attach the defined network interface
    device_index         = 0                                 # Set as the primary network interface
  }
}
