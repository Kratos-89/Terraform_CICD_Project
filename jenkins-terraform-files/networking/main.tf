variable "vpc_block" {}
variable "vpc_name" {}
variable "cidr_public_subnet" {}
variable "cidr_private_subnet" {}
variable "availability_zone_jenkins" {}
variable "igw_name_jenkins" {}
variable "jenkins-vpc-rt-public" {}
variable "jenkins-vpc-rt-private" {}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_subnet_id" {
  value = aws_subnet.public_subnet.*.id
}

output "vpc_subnet_cidr" {
  value = aws_subnet.public_subnet.*.cidr_block
}


resource "aws_vpc" "vpc"{
    cidr_block       = var.vpc_block
    instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet"{
  vpc_id = aws_vpc.vpc.id
  count = length(var.cidr_public_subnet)
  cidr_block = element(var.cidr_public_subnet,count.index)
  availability_zone = element(var.availability_zone_jenkins,count.index)
  tags = {
    Name = "Public-Subnet-${count.index+1}"
  }
}

resource "aws_subnet" "private_subnet"{
  vpc_id = aws_vpc.vpc.id
  count = length(var.cidr_private_subnet)
  cidr_block = element(var.cidr_private_subnet,count.index)
  availability_zone = element(var.availability_zone_jenkins,count.index)
  tags = {
    Name = "Private-Subnet-${count.index+1}"
  }
}

resource "aws_internet_gateway" "igw"{
  vpc_id = aws_vpc.vpc.id
  tags ={
    Name = var.igw_name_jenkins
  }
}

resource "aws_route_table" "route_table_public"{
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = var.jenkins-vpc-rt-public
  }
}

resource "aws_route_table_association" "public_assocation" {
  count = length(aws_subnet.public_subnet)
  subnet_id      = element(aws_subnet.public_subnet.*.id,count.index)
  route_table_id = aws_route_table.route_table_public.id
}

resource "aws_route_table" "route_table_private"{
  vpc_id = aws_vpc.vpc.id
  #depends_on = [aws_nat_gateway.nat_jenkins_gateway]
  tags = {
    Name = var.jenkins-vpc-rt-private
  }
}

resource "aws_route_table_association" "private_association"{
  count = length(aws_subnet.private_subnet)
  subnet_id = element(aws_subnet.private_subnet.*.id,count.index)
  route_table_id = aws_route_table.route_table_private.id
}

