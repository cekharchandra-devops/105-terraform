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
#     -backend-config="key=dev/ec2.tfstate" \
#     -backend-config="bucket=terraform-state-dcube" \
#     -backend-config="region=us-west-2" \
#     -backend-config="dynamodb_table=terraform_state_lock"