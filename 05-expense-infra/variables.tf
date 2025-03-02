variable "instances_info" {
  type = map(object({
    ami_id = string
    instance_type = string
    # vpc_security_group_ids = list(string)
    tags = map(string)
  }))
  default = {
    "mysql" = {
      ami_id = "ami-09c813fb71547fc4f"
      instance_type = "t3.micro"
    #   vpc_security_group_ids = [ "sg-0c1f2b3a4d5e6f7g" ]
      tags = {
        Name = "mysql"
      }
    }
    "backend" = {
      ami_id = "ami-09c813fb71547fc4f"
      instance_type = "t3.medium"
    #   vpc_security_group_ids = [ "sg-0c1f2b3a4d5e6f7g" ]
      tags = {
        Name = "backend"
      }
    }
    "frontend" = {
      ami_id = "ami-09c813fb71547fc4f"
      instance_type = "t3.small"
    #   vpc_security_group_ids = [ "sg-0c1f2b3a4d5e6f7g" ]
      tags = {
        Name = "frontend"
      }
    }
  }
  
}

variable "common_tags" {
  type = map(string)
  default = {
    "Environment" = "dev"
    "Project" = "expense"
    "Terraform" = "true"
  }
  
}

variable "zone_id" {
  type = string
  default = "Z081461419PCT70J0BCQ6"
  
}

variable "zone_name" {
  type = string
  default = "devsecmlops.online"
  
}