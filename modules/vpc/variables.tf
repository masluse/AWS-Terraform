# Variable for the name tag applied to the VPC.
variable "name" {
  type        = string
  description = "The name tag for the VPC."
}

# Variable for the CIDR block to assign to the VPC.
variable "cidr" {
  type        = string
  description = "The CIDR block for the VPC which defines its IP address range."
}
