# Variable definition for the 'name' variable, which is used to name resources.
variable "name" {
  type        = string
  description = "The name to assign to the resource"
}

# Variable definition for the 'cidr' variable, specifying the CIDR block for subnets.
variable "cidr" {
  type        = string
  description = "The CIDR block for the subnet"
}

# Variable definition for the 'vpc_id' variable, specifying the VPC in which resources will be created.
variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where resources will be deployed"
}

# Variable definition for the 'private' variable, to determine if resources should be private or not.
variable "private" {
  type        = bool
  description = "Indicates whether the resources should be private"
  default     = false
}

# Variable definition for the 'availability_zone' variable, specifying the availability zone for resources.
variable "availability_zone" {
  type        = string
  description = "The availability zone in which to create the resources"
}


# Local variables to determine subnet attributes based on whether it should be public or private.
locals {
  prv     = var.private == false ? true : "" # Sets 'prv' to true if 'private' is false; otherwise empty.
  pub     = var.private == true ? false : "" # Sets 'pub' to false if 'private' is true; otherwise empty.
  prv_pub = coalesce(local.prv, local.pub)   # Chooses the first non-empty value between 'prv' and 'pub'.
}