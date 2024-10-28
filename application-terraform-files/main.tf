 module "networking"{
  source = "./networking"
  vpc_name = var.vpc_name
  vpc_cidr_block = var.vpc_cidr_block
  cidr_public_subnet = var.cidr_public_subnet
  cidr_private_subnet = var.cidr_private_subnet
  availability_zone = var.availability_zone
}

module "security-group"{
  source = "./security-groups"
  ec2_sg_name = var.ec2_sg_name
  vpc_id = module.networking.vpc_id
  rds_sg_name = var.rds_sg_name
  public_subnet_cidr_block = var.cidr_public_subnet
  pythonApi-sg-name = var.pythonApi-sg-name
  vpc_block = [var.vpc_cidr_block]
}

module "application-instance" {
  source = "./ec2-instance"
  ami_id = var.ec2_ami_id
  instance_type = var.ec2_instance_type
  tag_name=var.ec2_tag_name
  key_name = var.ec2_key_name
  subnet_id = tolist(module.networking.public_subnet_id)[0]
  vpc_ec2_sg = module.security-group.ec2-sg-id
  vpc_pythonApi_sg = module.security-group.pythonApi-sg-id
  enable_public_ip_address = var.enable_public_ip_address
  user_data = templatefile("./ec2-template/script.sh",{})
}

module "alb-target_group"{
  source = "./target_group"
  lb_target_group_name = var.lb_target_group_name
  lb_target_group_port=var.lb_target_group_port
  lb_target_group_protocol=var.lb_target_group_protocol
  vpc_id=module.networking.vpc_id
  ec2_instance_id=module.application-instance.instance_id

}


module "application_loadBalancer" {
  source = "./application-lb"
  lb_name = var.lb_name
  is_external=var.is_external
  lb_type=var.lb_type
  ec2_sg=module.security-group.ec2-sg-id
  subnet_ids=tolist(module.networking.public_subnet_id)
  lb_target_group_arn=module.alb-target_group.alb_tg_arn
  ec2_instance_id=module.application-instance.instance_id
  lb_target_group_attachment_port=var.lb_target_group_attachment_port
  lb_listner_port=var.lb_listner_port
  lb_listner_protocol=var.lb_listner_protocol
  lb_listner_default_action=var.lb_listner_default_action
  lb_https_listner_port=var.lb_https_listner_port
  lb_https_listner_protocol=var.lb_https_listner_protocol
  acm_arn=module.acm-certification.acm-cerf-arn
}

module "hosted_zone"{
  source = "./hosted-zone"
  domain_name = var.domain_name
  aws_lb_dns_name = module.application_loadBalancer.alb_dns
  aws_lb_zone_id = module.application_loadBalancer.alb_zone_id

}

module "acm-certification" {
  source = "./acm-certificate"
  domain_name = var.domain_name
  hosted_zone_id = module.hosted_zone.hosted_zone_id
}

module "rds_instance" {
  source = "./rds_instance"
  db_subnet_group_name = var.db_subnet_group_name
  subnet_groups = tolist(module.networking.public_subnet_id)
  mysql_db_identifier  = var.mysql_db_identifier
  mysql_username       = var.mysql_username
  mysql_password       = var.mysql_password
  mysql_dbname         = var.mysql_dbname
  rds_mysql_sg = module.security-group.rds-sg-id
}