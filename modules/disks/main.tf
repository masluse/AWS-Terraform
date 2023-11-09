# This resource defines an AWS EBS volume with a given size and type in a specific availability zone.
resource "aws_ebs_volume" "default" {
  availability_zone = var.availability_zone # Specifies the AZ in which to create the volume.
  size              = var.size              # Size of the volume in GiBs.
  type              = var.type              # The type of the volume (gp2, io1, sc1, st1, etc.).

  tags = {
    Name = var.name  # Tags the EBS volume with a name for identification.
  }
}

# This resource attaches the defined EBS volume to a specified EC2 instance.
resource "aws_volume_attachment" "default" {
  device_name = var.device_name # The device name to expose to the instance (e.g., /dev/sdh).
  volume_id   = aws_ebs_volume.default.id # The ID of the EBS volume to attach.
  instance_id = var.aws_instance_id       # The ID of the instance to which the volume will attach.
}
