locals {
  instance_type = var.environment == "dev" ? "t2.micro" : "t2.large"
}