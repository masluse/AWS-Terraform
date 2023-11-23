# Resource definition for an AWS Security Group with dynamic ingress and egress rules.
resource "aws_security_group" "default" {
  name        = var.name           # The name of the security group.
  description = var.description    # The description of the security group.
  vpc_id      = var.vpc_id         # The VPC ID where the security group will be created.

  # Dynamic block for ingress rules, iterates over each ingress rule provided.
  dynamic "ingress" {
    for_each = var.ingress_rules   # The list of ingress rules.
    content {
      from_port   = ingress.value.from_port  # Starting port range.
      to_port     = ingress.value.to_port    # Ending port range.
      protocol    = ingress.value.protocol   # The protocol used (e.g., tcp, udp, icmp).
      cidr_blocks = length(ingress.value.cidr_blocks) > 0 ? ingress.value.cidr_blocks : null
      security_groups = length(ingress.value.security_groups) > 0 ? ingress.value.security_groups : null
    }
  }

  # Dynamic block for egress rules, iterates over each egress rule provided.
  dynamic "egress" {
    for_each = var.egress_rules   # The list of egress rules.
    content {
      from_port   = egress.value.from_port   # Starting port range.
      to_port     = egress.value.to_port     # Ending port range.
      protocol    = egress.value.protocol    # The protocol used.
      cidr_blocks = length(egress.value.cidr_blocks) > 0 ? egress.value.cidr_blocks : null
      security_groups = length(egress.value.security_groups) > 0 ? egress.value.security_groups : null
    }
  }

  # Tag the security group with a name.
  tags = {
    Name = var.name
  }
}
