resource "aws_key_pair" "default" {
  key_name   = var.name
  public_key = var.key
}