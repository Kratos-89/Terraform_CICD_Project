
module "networking"{
  source = "./networking"
  vpc_name = var.vpc_name
  vpc_block = var.vpc_block
  cidr_public_subnet = var.cidr_public_subnet
  cidr_private_subnet = var.cidr_private_subnet
  availability_zone_jenkins = var.availability_zone_jenkins
  igw_name_jenkins = var.igw_name_jenkins
  jenkins-vpc-rt-public = var.jenkins-vpc-rt-public
  jenkins-vpc-rt-private = var.jenkins-vpc-rt-private
}

module "security_group" {
  source = "./security_group"
  aws_lb_sg_name = var.ec2_sg_name
  aws_jenkins_sg_name = var.jenkins_sg_name
  vpc_id = module.networking.vpc_id
}

module "jenkins" {
  source = "./jenkins"
  ami_id = var.ami_id
  instance_type = var.instance_type
  tag_name = var.tag_name
  key_name = var.key_name
  subnet_id = tolist(module.networking.vpc_subnet_id)[0]
  jenkins_sg = [module.security_group.jenkins-sg,module.security_group.ec2-sg]
  public_ip = var.public_ip
  userdata = templatefile(var.userdata,{})
}

module "loadbalancer-tg"{
  source = "./loadbalancer-tg"
  alb-tg-name = var.alb-tg-name
  alb-tg-port = var.alb-tg-port
  alb-tg-protocol = var.protocol
  vpc_id = module.networking.vpc_id
  ec2_instance_id = module.jenkins.ec2-instance-id
}

module "loadbalancer"{
  source = "./loadbalancer"
  alb-name = var.alb-name
  is_external = var.is_external
  loadbalancer_type = var.loadbalancer_type
  alb-sg = module.security_group.ec2-sg
  subnets_id = tolist(module.networking.vpc_subnet_id)
  tg-arn = module.loadbalancer-tg.tg-arn
  target_id = module.jenkins.ec2-instance-id
  port_tg_attachement = var.instance_port_attach
  http_port = var.http_port
  http_protocol = var.http_protocol
  https_protocol = var.https_protocol
  https_port = var.https_port
  https_action = var.https_action
  lb_http_action = var.https_action
  certificate_arn = module.aws_ceritification_manager.acm-cerf
}

module "hosted_zone"{
  source = "./hosted_zone"
  domain_name = var.domain_name_jenkins
  dns_name = module.loadbalancer.alb_dns
  aws_lb_zone_id = module.loadbalancer.alb_zone_id
}

module "aws_ceritification_manager" {
  source         = "./certificate-manager"
  domain_name    = var.domain_name_jenkins
  hosted_zone_id = module.hosted_zone.hosted_zone_id
}