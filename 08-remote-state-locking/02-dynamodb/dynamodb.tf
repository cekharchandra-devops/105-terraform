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


resource "aws_dynamodb_table" "remote_state_lock_table" {
    name           = "joindevops-remote-state-locking"
    # read_capacity  = 20
    # write_capacity = 20
    billing_mode = "PAY_PER_REQUEST"
    hash_key       = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}