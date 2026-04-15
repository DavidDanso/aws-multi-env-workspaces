# Security group with (SSH + HTTP/HTTPS ingress, all egress)
resource "aws_security_group" "web" {
  name        = "${terraform.workspace}-web-sg"
  description = "Allow SSH and HTTP/HTTPS inbound, all outbound"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # Egress rules
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${terraform.workspace}-web-sg"
    Environment = terraform.workspace
  }
}