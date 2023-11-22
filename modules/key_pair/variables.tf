# Variable declaration for the name of the key pair.
variable "name" {
  type        = string
  description = "The name of the AWS key pair to create"
  # The description should be specific to the key pair name, not a generic 'Virtual Machine type'.
}

# Variable declaration for the public key material.
variable "key" {
  type        = string
  description = "The public key material for the AWS key pair"
  # The description should indicate that this is the public key data, not a generic 'Virtual Machine type'.
}
