resource "aws_security_group" "allow_ssh_ec2" {
  name        = "main"
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
    tags = merge(
    var.common_tags,
        {
        Name = "allow_ssh_ec2"
        }
    )
  
}

resource "aws_instance" "main" {
  ami = "ami-09c813fb71547fc4f"
  instance_type =  var.environment == "prod" ?  "t3.small" : "t3.micro"
  vpc_security_group_ids = [ aws_security_group.allow_ssh_ec2.id ]
    tags = merge(
        var.common_tags,
        {
        Name = "main"
        }
    )
}