variable "name" {
  type        = string
  description = "The name of the VM instance to create"
}

variable "description" {
  type        = string
  description = "Virtual Machine type"
}

variable "vpc_id" {
  type        = string
  description = "Virtual Machine type"
}

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

variable "egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}