variable "ami_id" {}
variable "instance_type" {}
variable "tag_name" {}
variable "key_name" {}
variable "subnet_id" {}
variable "jenkins_sg" {}
variable "public_ip" {}
variable "userdata" {}

output "ec2-instance-id"{
  value = aws_instance.jenkins.id
}

output "ec2-instance-ip" {
  value = aws_instance.jenkins.public_ip
}

output "ec2-endpoint" {
  value = format("%s%s","ssh -i /e/Devops/AWS/Virginia/jenkins-key.pem ubuntu@",aws_instance.jenkins.public_ip)
}

resource "aws_instance" "jenkins"{
  ami = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = var.tag_name
  }
  key_name = var.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.jenkins_sg
  associate_public_ip_address = var.public_ip
  user_data = var.userdata

  metadata_options{
    http_endpoint = "enabled"
    http_tokens = "required"
  }
}
