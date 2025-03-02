resource "aws_security_group" "allow_ssh_ec2" {
  name = "allow_ssh_ec2"
  description = "Allow inbound traffic"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    tags = {
        Name = "allow_ssh_ec2"
    }
  
}

resource "aws_instance" "instances_loop" {
  count = length(var.instances)
  ami = "ami-09c813fb71547fc4f"
  instance_type =  var.instances[count.index] == "mysql" ? "t3.small" : "t3.micro"
  vpc_security_group_ids = [ aws_security_group.allow_ssh_ec2.id ]
    tags = {
        Name = "main"
    }
}

resource "aws_instance" "ec2_for_each" {
  for_each = var.instances_info

  ami                    = each.value.ami_id
  instance_type          = each.value.instance_type
  vpc_security_group_ids = each.value.vpc_security_group_ids
  tags                   = each.value.tags
}

# resource "aws_instance" "instances" {
#   for_each = var.instances_info

#   ami                    = each.value.ami_id
#   instance_type          = each.value.instance_type
#   vpc_security_group_ids = each.value.vpc_security_group_ids
#   subnet_id              = each.value.subnet_id
#   key_name               = each.value.key_name
#   iam_instance_profile   = each.value.iam_instance_profile
#   user_data              = each.value.user_data

#   root_block_device {
#     volume_size = each.value.root_volume_size
#     volume_type = each.value.root_volume_type
#   }

#   # Optional block - Only added if extra_volumes is NOT empty
#   dynamic "ebs_block_device" {
#     for_each = length(each.value.extra_volumes) > 0 ? each.value.extra_volumes : []
#     content {
#       device_name = ebs_block_device.value.device_name
#       volume_size = ebs_block_device.value.volume_size
#       volume_type = ebs_block_device.value.volume_type
#     }
#   }

#   tags = each.value.tags
# }
