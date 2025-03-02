variable "environment" {
  default = "dev"
}

variable "instances" {
  type = list(string)
  default = ["mysql", "backend", "frontend"]
}

variable "ami_id" {
  type = string
  default = "ami-09c813fb71547fc4f"
}

variable "common_tags" {
  type = map(string)
  default = {
    "Terraform" = "true"
    "project" = "Expense"
    "Environment" = "dev"
  }
}

variable "instance_type" {
  type = map(string)
  default = {
    "mysql_instance_type" = "t3.micro"
    "backend_instance_type" = "t3.medium"
    "frontend_instance_type" = "t3.small"
  }
  
}

# variable "mysql_instance_type" {
#   type = string
#   default = "t3.micro"
# }

# variable "backend_instance_type" {
#   type = string
#   default = "t3.medium"
# }

# variable "frontend_instance_type" {
#   type = string
#   default = "t3.small"
# }

variable "instance_tags" {
  type = map(map(string))
  default = {
    "mysql_tags" = {
      "Name" = "mysql"
    }
    "backend_tags" = {
      "Name" = "backend"
    }
    "frontend_tags" = {
      "Name" = "frontend"
    }
  }
  
}

# variable "mysql_tags" {
#   type = map(string)
#   default = {
#     "Name" = "mysql"
#   }
# }

# variable "backend_tags" {
#   type = map(string)
#   default = {
#     "Name" = "backend"
#   }
# }

# variable "frontend_tags" {
#   type = map(string)
#   default = {
#     "Name" = "frontend"
#   }
# }

variable "instances_info" {
  type = map(object({
    instance_type         = string
    vpc_security_group_ids = list(string)
    ami_id               = string
    tags                 = map(string)
  }))
  default = {
    "frontend" = {
      instance_type         = "t3.micro"
      vpc_security_group_ids = ["sg-frontend"]
      ami_id               = "ami-0c55b159cbfafe1f0"
      tags = {
        Name  = "frontend-instance"
        Role  = "Frontend"
        Owner = "DevTeam"
      }
    }
    "backend" = {
      instance_type         = "t3.medium"
      vpc_security_group_ids = ["sg-backend"]
      ami_id               = "ami-0b898040803850657"
      tags = {
        Name  = "backend-instance"
        Role  = "Backend"
        Owner = "DevTeam"
      }
    }
    "database" = {
      instance_type         = "t3.large"
      vpc_security_group_ids = ["sg-database"]
      ami_id               = "ami-1234567890abcdef0"
      tags = {
        Name  = "database-instance"
        Role  = "Database"
        Owner = "DBAdmin"
      }
    }
  }
}

# variable "instances_info" {
#   type = map(object({
#     instance_type          = string
#     ami_id                = string
#     vpc_security_group_ids = list(string)
#     subnet_id             = string
#     key_name              = string
#     iam_instance_profile  = string
#     root_volume_size      = number
#     root_volume_type      = string
#     extra_volumes         = list(object({
#       device_name = string
#       volume_size = number
#       volume_type = string
#     }))
#     tags                  = map(string)
#     user_data             = string
#   }))

#   default = {
#     "frontend" = {
#       instance_type          = "t3.micro"
#       ami_id                = "ami-0c55b159cbfafe1f0"
#       vpc_security_group_ids = ["sg-frontend"]
#       subnet_id             = "subnet-frontend"
#       key_name              = "production-key"
#       iam_instance_profile  = "frontend-instance-profile"
#       root_volume_size      = 20
#       root_volume_type      = "gp3"
#       extra_volumes = [
#         { device_name = "/dev/sdb", volume_size = 10, volume_type = "gp3" }
#       ]
#       tags = {
#         Name  = "frontend-instance"
#         Role  = "Frontend"
#         Owner = "DevOpsTeam"
#         Env   = "Production"
#       }
#       user_data = <<-EOF
#         #!/bin/bash
#         yum update -y
#         amazon-linux-extras enable nginx1
#         yum install -y nginx
#         systemctl start nginx
#         systemctl enable nginx
#       EOF
#     }

#     "backend" = {
#       instance_type          = "t3.medium"
#       ami_id                = "ami-0b898040803850657"
#       vpc_security_group_ids = ["sg-backend"]
#       subnet_id             = "subnet-backend"
#       key_name              = "production-key"
#       iam_instance_profile  = "backend-instance-profile"
#       root_volume_size      = 50
#       root_volume_type      = "gp3"
#       extra_volumes = [
#         { device_name = "/dev/sdb", volume_size = 50, volume_type = "gp3" },
#         { device_name = "/dev/sdc", volume_size = 100, volume_type = "st1" }
#       ]
#       tags = {
#         Name  = "backend-instance"
#         Role  = "Backend"
#         Owner = "BackendTeam"
#         Env   = "Production"
#       }
#       user_data = <<-EOF
#         #!/bin/bash
#         yum update -y
#         yum install -y docker
#         systemctl start docker
#         systemctl enable docker
#       EOF
#     }

#     "database" = {
#       instance_type          = "t3.large"
#       ami_id                = "ami-1234567890abcdef0"
#       vpc_security_group_ids = ["sg-database"]
#       subnet_id             = "subnet-database"
#       key_name              = "production-key"
#       iam_instance_profile  = "database-instance-profile"
#       root_volume_size      = 100
#       root_volume_type      = "gp3"
#       extra_volumes = [
#         { device_name = "/dev/sdb", volume_size = 200, volume_type = "gp3" }
#       ]
#       tags = {
#         Name  = "database-instance"
#         Role  = "Database"
#         Owner = "DBAdmin"
#         Env   = "Production"
#       }
#       user_data = <<-EOF
#         #!/bin/bash
#         yum update -y
#         yum install -y mariadb-server
#         systemctl start mariadb
#         systemctl enable mariadb
#       EOF
#     }
#   }
# }
