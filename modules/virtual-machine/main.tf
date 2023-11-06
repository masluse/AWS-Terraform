resource "aws_network_interface" "default" {
  subnet_id       = var.subnet_id
}

resource "aws_instance" "default" {
  ami = var.image
  instance_type = var.type
  key_name = var.key_pair
  tags = {
    Name = var.name
  }
  root_block_device {
    volume_size = var.disk_size
    volume_type = var.disk_type
  }
  network_interface {
    network_interface_id = aws_network_interface.default.id
    device_index         = 0
  }
}