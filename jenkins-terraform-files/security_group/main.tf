variable "aws_lb_sg_name" {}
variable "aws_jenkins_sg_name" {}
variable "vpc_id" {}

output "jenkins-sg" {
  value = aws_security_group.ec2-jenkins-sg.id
}

output "ec2-sg" {
  value = aws_security_group.ec2-sg.id
}

resource "aws_security_group" "ec2-sg"{
  name = var.aws_lb_sg_name
  description = "Security group of EC2 instances"
  vpc_id = var.vpc_id
  
  tags = {
    Environment = "Project-Testing"
  }

  ingress {
    description = "Allow incoming SSH"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }

  ingress {
    description = "Allow incoming and HTTP"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }

  ingress {
    description = "Allow request 443 from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 443
    to_port = 443
    protocol = "tcp"
  }

  egress {
    description = "Allow outgoing request"
    from_port = 0
    to_port = 0
    protocol = -1 # -1 specifies all protocols like http, https..etc.
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ec2-jenkins-sg" {
  name = var.aws_jenkins_sg_name
  description = "To Enable port 8080 for jenkins"
  vpc_id = var.vpc_id
  
  tags = {
    Environment = "Project-Testing"
  }
  
  ingress{
    description = "Allow port 8080 for jenkins"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
  }

   egress {
    description = "Allow outgoing request"
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}