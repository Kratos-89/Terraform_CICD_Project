vpc_name = "Application_vpc"
vpc_cidr_block = "10.0.0.0/16"
cidr_public_subnet = ["10.0.1.0/24","10.0.2.0/24"]
cidr_private_subnet = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zone = ["us-east-1a","us-east-1b"]
ec2_sg_name = "http-sg"
rds_sg_name = "rds-sg"
pythonApi-sg-name = "pythonApi-sg"
ec2_ami_id = "ami-005fc0f236362e99f"
ec2_instance_type = "t2.micro"
ec2_tag_name = "Application-instance"
ec2_key_name = "client-key"
enable_public_ip_address = true
lb_target_group_name = "Application-ALB-Tg"
lb_target_group_port=500
lb_target_group_protocol="HTTP"
lb_name = "Application-lb"
is_external = false
lb_type = "application"
lb_target_group_attachment_port = 5000
lb_listner_port=5000
lb_listner_protocol="HTTP"
lb_listner_default_action="forward"
lb_https_listner_port=443
lb_https_listner_protocol="HTTPS"
domain_name = "app.ravin.store"
db_subnet_group_name = "rds_subnet_group"
mysql_db_identifier  = "mydb"
mysql_username       = "dbuser"
mysql_password       = "dbpassword"
mysql_dbname         = "devprojdb"