# This resource is used to manage an AWS key pair, which is associated with EC2 instances to enable SSH access.
resource "aws_key_pair" "default" {
  key_name   = var.name    # The name of the key pair, which will be used to refer to it within AWS.
  public_key = var.key     # The public key material. This public key will be stored in AWS to pair with the private key.
}
