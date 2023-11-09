# Variable to define the allocated storage for the RDS instance.
variable "storage" {
  type        = string
  description = "The allocated storage for the RDS instance."
}

# Remaining variables with descriptions that need to be adjusted for accuracy:
variable "db_name" {
  type        = string
  description = "The name of the database for the RDS instance."
}

variable "engine" {
  type        = string
  description = "The database engine for the RDS instance."
}

variable "engine_version" {
  type        = string
  description = "The engine version for the RDS instance."
}

variable "instance_class" {
  type        = string
  description = "The instance class for the RDS instance."
}

variable "username" {
  type        = string
  description = "The master username for the RDS instance."
}

variable "password" {
  type        = string
  description = "The master password for the RDS instance."
}

variable "vpc_security_group_ids" {
  type        = string
  description = "The security group IDs associated with the RDS instance."
}

variable "subnet_ids" {
  type        = list(string)
  description = "The subnet IDs for the RDS instance."
}
