terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.89.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
  
}


resource "aws_s3_bucket" "remote_state_bucket" {
    bucket = "joindevops-remote-state-locking"
}

resource "aws_s3_bucket_versioning" "terraform-state-locking" {
    bucket = aws_s3_bucket.remote_state_bucket.bucket
    versioning_configuration {
        status = "Enabled"
    }
}