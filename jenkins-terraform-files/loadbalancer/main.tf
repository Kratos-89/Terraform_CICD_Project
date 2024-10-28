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
  internal = var.is_external
  load_balancer_type = var.loadbalancer_type
  security_groups = [var.alb-sg]
  subnets = var.subnets_id
  enable_deletion_protection = false

  tags = {
    Name = "example-lb"
  }
}

resource "aws_lb_target_group_attachment" "alb-arn-attachement"{
  target_group_arn = var.tg-arn
  target_id = var.target_id
  port = var.port_tg_attachement
}

resource "aws_lb_listener" "http_listner"{
  load_balancer_arn = aws_lb.test-alb.arn
  port = var.http_port
  protocol = var.http_protocol
  default_action{
    type = var.lb_http_action
    target_group_arn = var.tg-arn
  }
}

resource "aws_lb_listener" "https_listner"{
  load_balancer_arn = aws_lb.test-alb.arn
  port = var.https_port
  protocol = var.https_protocol
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.certificate_arn
  default_action {
    type = var.https_action
    target_group_arn = var.tg-arn
  }
}

#time -> 1:29:40