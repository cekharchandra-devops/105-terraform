terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.89.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}


terraform {
  backend "s3" {
  }
}

resource "aws_instance" "ec2" {
  ami = "ami-09c813fb71547fc4f"
  instance_type = "t3.micro"
  tags = {
    Name = "ec2"
  }
}

# terraform init \
#     -backend-config="key=dev/terraform.tfstate" \
#     -backend-config="bucket=joindevops-remote-state-locking" \
#     -backend-config="region=us-west-2" \
#     -backend-config="dynamodb_table=remote_state_lock_table"