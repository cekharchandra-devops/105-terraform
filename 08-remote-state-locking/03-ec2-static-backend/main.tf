resource "aws_instance" "ec2" {
  ami = "ami-09c813fb71547fc4f"
  instance_type = "t3.micro"
#   vpc_security_group_ids = [ aws_security_group.allow_ssh_ec2.id ]
  tags = {
    Name = "ec2"
  }
}
