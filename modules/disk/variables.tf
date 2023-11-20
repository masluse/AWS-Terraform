# Variable Definitions
variable "name" {
  type        = string
  description = "The name tag for the EBS volume"
}

variable "availability_zone" {
  type        = string
  description = "The availability zone for the EBS volume"
}

variable "size" {
  type        = number
  description = "The size of the EBS volume in GiBs"
}

variable "type" {
  type        = string
  description = "The type of the EBS volume (e.g., gp2, io1, sc1, st1)"
}

variable "aws_instance_id" {
  type        = string
  description = "The AWS instance ID for volume attachment"
}

variable "device_name" {
  type        = string
  description = "The device name for the attached volume" 
}
