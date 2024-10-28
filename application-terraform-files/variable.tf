variable "vpc_name"{
  description = "VPC Name"
  type = string
}

variable "vpc_cidr_block"{
  description = "cidr block of vpc"
  type = string
}

variable "cidr_public_subnet"{
  description = "Public subnet cidr block"
  type = list(string)
}

variable "cidr_private_subnet"{
  description = "Private subnet cidr block"
  type = list(string)
}

variable "availability_zone"{
  description = "us-east-1"
  type = list(string)
}

variable "ec2_sg_name"{
  description = "ec2 sg name"
  type = string
}

variable "rds_sg_name"{
  description = "sg name of rds"
  type = string
}

variable "pythonApi-sg-name"{
  description = "PythonApi sg name"
  type = string
}

variable "ec2_ami_id"{
  description = "ec2 instance ami id"
  type = string
}

variable "ec2_instance_type"{
  description = "instance type of python instance"
  type = string
}

variable "ec2_tag_name"{
  description = "python instance tag name"
  type = string
}

variable "ec2_key_name"{
  description = "Key name of python instance"
  type = string
}


variable "enable_public_ip_address"{
  description = "Trur or false to auto assign public ip for python instance"
  type = bool
}

variable "lb_target_group_name"{
  description = "Target group name of alb"
  type = string
}

variable "lb_target_group_port"{
  description = "Port number of Tg"
  type = number
}

variable "lb_target_group_protocol"{
  description = "Protocol of TG"
  type = string
}

variable "lb_name"{
  description = "Name of Application Load balancer"
  type = string
}

variable "is_external"{
  description = "If loadbalancer is in external network"
  type = bool
}

variable "lb_type"{
  description = "Type of loadbalancer"
  type = string
}


variable "lb_target_group_attachment_port"{
  description = "Tg to LB attachement port"
  type = number
}


variable "lb_listner_port"{
  description = "Application request listener"
  type = number
}


variable "lb_listner_protocol"{
  description = "Application request protoccol"
  type = string
}


variable "lb_listner_default_action"{
  description = "Listener action"
  type = string
}


variable "lb_https_listner_port"{
  description = "https port"
  type = number
}


variable "lb_https_listner_protocol"{
  description = "https protocol"
  type = string
}


variable "domain_name"{
  description = "Domain Name"
  type = string
}


variable "db_subnet_group_name"{
  description = "db subnet group name"
  type = string
}


variable "mysql_db_identifier"{
  description = "Mysql Database identifier"
  type = string
}

variable "mysql_username"{
  description = "Mysql  User name"
  type = string
}


variable "mysql_password"{
  description = "Mysql DB password"
  type = string
}


variable "mysql_dbname"{
  description = "Mysql DB name"
  type = string
}


# variable ""{
#   description = ""
#   type = string
# }


# variable ""{
#   description = ""
#   type = string
# }

