# Variable for the name tag of the EBS volume.
variable "name" {
  type        = string
  description = "The name tag for the EBS volume"
}

# Variable for the availability zone where the EBS volume will be created.
variable "availability_zone" {
  type        = string
  description = "The availability zone in which to create the EBS volume"
}

# Variable for the size of the EBS volume in GiBs.
variable "size" {
  type        = number  # The type here should be 'number' as size is numerical.
  description = "The size of the EBS volume in GiBs"
}

# Variable for the type of the EBS volume (e.g., gp2, io1, etc.).
variable "type" {
  type        = string
  description = "The type of the EBS volume (e.g., gp2, io1, sc1, st1)"
}

# Variable for the AWS instance ID to which the volume will be attached.
variable "aws_instance_id" {
  type        = string
  description = "The ID of the AWS instance to which the volume will be attached"
}

# Variable for the device name that the attached volume will be exposed as on the instance.
variable "device_name" {
  type        = string
  description = "The device name to expose the attached volume on the instance"
}
