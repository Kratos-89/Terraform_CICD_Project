variable "vpc_name" {
  description = "VPC Name"
  type = string
}

variable "vpc_block" {
  description = "VPC CIDR Block"
  type = string
}

variable "cidr_public_subnet"{
  description = "public subnets"
  type = list(string)
}


variable "cidr_private_subnet"{
  description = "private subnets"
  type = list(string)
}

variable "availability_zone_jenkins" {
  description = "Availability Zones"
  type = list(string)
}

variable "igw_name_jenkins" {
  description = "Name of Jenkins Gateway"
  type = string
}

variable "jenkins-vpc-rt-public" {
  description = "Name of Jenkins VPC Route Table public"
  type = string
}

variable "jenkins-vpc-rt-private" {
  description = "Name of Jenkins VPC Route Table private"
  type = string
}


variable "ec2_sg_name" {
  description = "EC2 security group Name"
  type = string
}

variable "jenkins_sg_name" {
  description = "jenkins security group Name"
  type = string
}

variable "ami_id" {
  description = "AMI ID"
  type = string
}

variable "instance_type"{
  description = "Instance Type"
  type = string
}
 variable "tag_name"{
  description = "Instance Tag name"
  type = string
 }

variable "key_name"{
  description = "Key Name"
  type = string
}

variable "public_ip" {
  description = "Public ip set to true"
  type = bool
}

variable "userdata" {
  description = "Userdata Script"
  type = string
}

variable "alb-tg-name" {
  description = "ALB TG Name"
  type = string
}

variable "alb-tg-port"{
  description = "Port number"
  type = string
}

variable "protocol" {
  description = "Protocol"
  type = string
}

variable "alb-name"{
  description = "alb-NAME"
  type = string
}

variable "is_external"{
  description = "Load Balancer region"
  type = bool
}

variable "loadbalancer_type"{
  description = "Load Balancer type"
  type = string
}

variable "instance_port_attach"{
  description = "Instance incoming traffic port"
  type = number
}

variable "http_port"{
  description = "http port"
  type = number
}

variable "http_protocol"{
  description = "http protocol"
  type = string
}


variable "https_protocol"{
  description = "https portocol"
  type = string
}


variable "https_port"{
  description = "https port"
  type = number
}

variable "https_action"{
  description = "https action"
  type = string
}

variable "certificate_arn"{
  description = "certificate arn"
  type = string
}

variable "domain_name_jenkins"{
  description = "jenkins_instance_domain_name"
  type = string
}