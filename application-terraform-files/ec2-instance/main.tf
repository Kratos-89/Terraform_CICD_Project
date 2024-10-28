variable "ami_id" {}
variable "instance_type" {}
variable "tag_name" {}
variable "key_name" {}
variable "subnet_id" {}
variable "vpc_ec2_sg" {}
variable "vpc_pythonApi_sg" {}
variable "enable_public_ip_address" {}
variable "user_data" {}

output "instance_id"{
value = aws_instance.python-instance.id
}

output "instance_ip"{
  value = aws_instance.python-instance.public_ip
}

resource "aws_instance" "python-instance"{
  ami = var.ami_id
  instance_type = var.instance_type 
  tags = {
    Name = var.tag_name
  }
  key_name = var.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = [var.vpc_ec2_sg, var.vpc_pythonApi_sg]
  associate_public_ip_address = var.enable_public_ip_address
  user_data = var.user_data

  metadata_options {
  http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
  http_tokens   = "required" # Require the use of IMDSv2 tokens
  }
}



