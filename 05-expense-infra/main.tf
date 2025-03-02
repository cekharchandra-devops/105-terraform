resource "aws_security_group" "main" {
  name        = "allow_ssh_ec2"
  description = "Allow inbound traffic"
  ingress {
    from_port   = 22    
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

resource "aws_instance" "main" {
  for_each = var.instances_info
  ami = each.value.ami_id
  instance_type = each.value.instance_type
  vpc_security_group_ids = [ aws_security_group.main.id ]
    tags = merge(
        var.common_tags,
        {Name = each.key}
        )
        
}

resource "aws_route53_record" "private_records" {
  for_each = aws_instance.main
  zone_id = var.zone_id
  name    = "${each.key}.${var.zone_name}"
  type    = "A"
  ttl     = 1
  records = [each.value.private_ip]
  allow_overwrite = true
}


resource "aws_route53_record" "public_record" {
  for_each = { for k, v in aws_instance.main : k => v if k == "frontend" }
  zone_id = var.zone_id
  name    = var.zone_name
  type    = "A"
  ttl     = 1
  records = [each.value.public_ip]
  allow_overwrite = true
}