variable "lb_name" {}
variable "is_external" {}
variable "lb_type" {}
variable "ec2_sg" {}
variable "subnet_ids" {}
variable "lb_target_group_arn" {}
variable "ec2_instance_id" {}
variable "lb_target_group_attachment_port" {}
variable "lb_listner_port" {}
variable "lb_listner_protocol" {}
variable "lb_listner_default_action" {}
variable "lb_https_listner_port" {}
variable "lb_https_listner_protocol" {}
variable "acm_arn" {}


output "alb_dns"{
  value = aws_lb.app-lb.dns_name
}

output "alb_zone_id"{
  value = aws_lb.app-lb.zone_id
}

resource "aws_lb" "app-lb" {
  name               = var.lb_name
  internal           = var.is_external
  load_balancer_type = var.lb_type
  security_groups    = [var.ec2_sg]
  subnets            = var.subnet_ids # Replace with your subnet IDs

  enable_deletion_protection = false

  tags = {
    Name = "Application_LoadBalancer"
  }
}

resource "aws_lb_target_group_attachment" "alb-tg-attachment" {
  target_group_arn = var.lb_target_group_arn
  target_id        = var.ec2_instance_id # Replace with your EC2 instance reference
  port             = var.lb_target_group_attachment_port
}

resource "aws_lb_listener" "alb_listener-1" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = var.lb_listner_port
  protocol          = var.lb_listner_protocol

  default_action {
    type             = var.lb_listner_default_action
    target_group_arn = var.lb_target_group_arn
  }
}

resource "aws_lb_listener" "alb_listener-2" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = var.lb_https_listner_port
  protocol          = var.lb_https_listner_protocol
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_arn

  default_action {
    type             = var.lb_listner_default_action
    target_group_arn = var.lb_target_group_arn
  }
}

