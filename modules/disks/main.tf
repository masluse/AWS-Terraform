resource "aws_ebs_volume" "default" {
  availability_zone = var.availability_zone
  size              = var.size
  type              = var.type

  tags = {
    Name = var.name
  }
}

resource "aws_volume_attachment" "default" {
  device_name = var.device_name
  volume_id   = aws_ebs_volume.default.id
  instance_id = var.aws_instance_id
}