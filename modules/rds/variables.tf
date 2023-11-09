variable "storage" {
  type        = string
  description = "The name of the VM instance to create"
}

variable "db_name" {
  type        = string
  description = "Virtual Machine type"
}

variable "engine" {
  type        = string
  description = "Virtual Machine type"
}

variable "engine_version" {
  type        = string
  description = "The name of the VM instance to create"
}

variable "instance_class" {
  type        = string
  description = "Virtual Machine type"
}

variable "username" {
  type        = string
  description = "Virtual Machine type"
}

variable "password" {
  type        = string
  description = "Virtual Machine type"
}

variable "vpc_security_group_ids" {
  type        = string
  description = "Virtual Machine type"
}

variable "db_subnet_group_name" {
  type        = string
  description = "Virtual Machine type"
}