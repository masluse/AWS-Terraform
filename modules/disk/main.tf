# EBS Volume Creation
resource "aws_ebs_volume" "default" {
  availability_zone = var.availability_zone          # Sets the availability zone for the volume.
  size              = var.size                       # Defines the size of the volume in GiBs.
  type              = var.type                       # Sets the type of the EBS volume.

  tags = {
    Name = var.name                                  # Adds a name tag to the volume.
  }
}

# EBS Volume Attachment
resource "aws_volume_attachment" "default" {
  device_name = var.device_name                      # Device name for the instance.
  volume_id   = aws_ebs_volume.default.id            # References the ID of the created EBS volume.
  instance_id = var.aws_instance_id                  # Specifies the instance to attach the volume to.
}

