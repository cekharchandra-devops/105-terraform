variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "component" {
  default = "ec2"
  
}

variable "common_tags" {
  type = map(string)
    default = {
        Name = "ec2_instance"
        Environment = "dev"
        Project = "expense"
    }
}