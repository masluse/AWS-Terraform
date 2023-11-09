# Variable for the common name tag applied to resources like EIP and NAT Gateway.
variable "name" {
  type        = string
  description = "The common name tag for resources such as EIP and NAT Gateway."
}

# Variable for the ID of the subnet where the NAT Gateway will be placed.
variable "subnet_id_place" {
  type        = string
  description = "The ID of the subnet in which the NAT Gateway will be placed."
}

# Variable for the ID of the subnet that will be associated with the route table.
variable "subnet_id_route" {
  type        = string
  description = "The ID of the subnet to be associated with the route table."
}

# Variable for the ID of the VPC where the route table and NAT Gateway will reside.
variable "vpc_id" {
  type        = string
  description = "The ID of the VPC associated with the route table and NAT Gateway."
}
