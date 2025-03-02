resource "aws_security_group" "allow_ssh_ec2" {
  name        = "allow_ssh_ec2"
  description = "Allow SSH inbound traffic"
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
  tags = {
    "Name" = "allow_ssh_ec2"
  }

}

resource "aws_instance" "ami_data_source" {
  ami                    = data.aws_ami.joindevops.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh_ec2.id]
  tags = {
    Name = "joindevops"
  }
}