variable "alb-name" {}
variable "is_external" {}
variable "loadbalancer_type" {}
variable "alb-sg" {}
variable "subnets_id" {}
variable "tg-arn" {}
variable "target_id" {}
variable "port_tg_attachement" {}
variable "http_port" {}
variable "http_protocol" {}
variable "lb_http_action" {}
variable "https_port" {}
variable "https_protocol" {}
variable "https_action" {}
variable "certificate_arn" {}


output "alb_dns"{
  value  = aws_lb.test-alb.dns_name
}

output "alb_zone_id"{
  value = aws_lb.test-alb.zone_id
}

resource "aws_lb" "test-alb" {
  name = var.alb-name
  internal = var.is_external # True or False to check if Loadbalacer is within the VPC?
  load_balancer_type = var.loadbalancer_type #Type -> application
  security_groups = [var.alb-sg]
  subnets = var.subnets_id
  enable_deletion_protection = false

  tags = {
    Name = "example-lb"
  }
}
#Attach a traget group to route the traffic to that particular target group
resource "aws_lb_target_group_attachment" "alb-arn-attachement"{ 
  target_group_arn = var.tg-arn
  target_id = var.target_id
  port = var.port_tg_attachement #Instance port's attachement 8080 to use jenkins
}

#Loadbalancer only listens to these below mentioned ports, there is also a seperate option to specify a target group to LB
resource "aws_lb_listener" "http_listner"{
  load_balancer_arn = aws_lb.test-alb.arn
  port = var.http_port #Listens to taraffic at port 80
  protocol = var.http_protocol
  default_action{
    type = var.lb_http_action #action -> forward
    target_group_arn = var.tg-arn #whatever it listens at port 80 are then forwarded to the target group
  }
}

resource "aws_lb_listener" "https_listner"{
  load_balancer_arn = aws_lb.test-alb.arn
  port = var.https_port
  protocol = var.https_protocol
  ssl_policy = "ELBSecurityPolicy-2016-08" 
  certificate_arn = var.certificate_arn #We need to specify the acm certificate of jenkins.ravin.store to use https
  default_action {
    type = var.https_action
    target_group_arn = var.tg-arn
  }
}

