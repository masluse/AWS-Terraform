# Variable declaration for the name of the key pair.
variable "name" {
  type        = string
  description = "The name of the AWS key pair"
}

# Variable declaration for the public key material.
variable "key" {
  type        = string
  description = "The public key material for the AWS key pair"
}
