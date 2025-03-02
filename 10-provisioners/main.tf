resource "aws_security_group" "allow_ssh_provisioner" {
  name        = "allow_ssh_provisioner"
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
    "Name" = "allow_ssh_provisioner"
  }

}

resource "aws_instance" "provisioner" {
  ami                    = "ami-09c813fb71547fc4f"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh_provisioner.id]
  tags = {
    Name = "provisioner"
  }

  provisioner "local-exec" {
    command = "echo 'instance id: ${self.id} : private_ip : ${self.private_ip}' > instance_id.txt"
  }
  connection {
    type = "ssh"
    user = "ec2-user"
    # private_key = file("C:/Users/HP/.ssh/id_rsa")
    password = "DevOps321"
    host     = self.public_ip
  }
  provisioner "remote-exec" {

    inline = [
      "sudo dnf install -y nginx",
      "systemctl start nginx",
      # "echo 'instance id: ${self.id} : private_ip : ${self.private_ip}' > instance_id.txt"

    ]
  }
  provisioner "file" {
    source      = "index.html"
    destination = "/usr/share/nginx/html/index.html"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /usr/share/nginx/html",
      "systemctl restart nginx"
    ]

  }
}


# In Terraform, when using multiple remote-exec provisioners within the same resource, 
# you do not need to repeat the connection block if the connection details are the same for all remote-exec
#  provisioners. Terraform will reuse the connection details from the first remote-exec provisioner for subsequent 
#  remote-exec provisioners within the same resource.
