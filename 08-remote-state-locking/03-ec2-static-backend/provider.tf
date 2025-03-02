terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "5.89.0"
        }
    }
    backend "s3" {
        bucket = "joindevops-remote-state-locking"
        key    = "dev/terraform.tfstate"
        region = "us-east-1"
        dynamodb_table = "remote_state_lock_table"
        encrypt = true
    }
}