resource "aws_instance" "ec2" {
  ami = "ami-09c813fb71547fc4f"
  instance_type = "t3.micro"
  vpc_security_group_ids = [ aws_security_group.allow_ssh_ec2.id ]
  tags = {
    Name = "ec2"
  }
}

resource "aws_security_group" "allow_ssh_ec2" {
  name = "allow_ssh_ec2"
  description = "Allow SSH inbound traffic"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
 tags = {
   Name = "allow_ssh_ec2"
 }
}