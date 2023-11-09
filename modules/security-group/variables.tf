# Variable to define the name of the security group.
variable "name" {
  type        = string
  description = "The name of the security group."
}

# Variable to provide a description for the security group.
variable "description" {
  type        = string
  description = "The description of the security group."
}

# Variable to specify the VPC ID where the security group will be created.
variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the security group will be created."
}

# Variable to define ingress rules for the security group.
variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

# Variable to define egress rules for the security group.
variable "egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}
