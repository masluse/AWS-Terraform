variable "name" {
  type        = string
  description = "The name of the VM instance to create"
}

variable "cidr" {
  type        = string
  description = "Virtual Machine type"
}

variable "vpc_id" {
  type        = string
  description = "Virtual Machine type"
}

variable "private" {
  type        = bool
  description = "Virtual Machine type"
  default     = false
}

variable "availability_zone" {
  type        = string
  description = "Virtual Machine type"
}
