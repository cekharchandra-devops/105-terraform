resource "aws_instance" "dynamic_block" {
  ami                    = "ami-09c813fb71547fc4f"
  vpc_security_group_ids = [aws_security_group.allow_ssh_dynamic.id]
  instance_type          = "t3.micro"
  tags = merge(
    var.common_tags,
    {
      Name = "dynamic_block"
    }
  )
}

resource "aws_security_group" "allow_ssh_dynamic" {
  name        = "allow-ssh-dynamic"
  description = "allow ssh on port 22"
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}