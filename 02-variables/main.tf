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
  tags = {
    
  }
}

resource "aws_instance" "variable_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ aws_security_group.allow_ssh_ec2.id ]
  tags = {
    Name = "main"
  }
  
}

# overwrite the default values of the variables with precedence

# Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

# Environment variables
# The terraform.tfvars file, if present.
# The terraform.tfvars.json file, if present.
# Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
# Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by an HCP Terraform workspace.)