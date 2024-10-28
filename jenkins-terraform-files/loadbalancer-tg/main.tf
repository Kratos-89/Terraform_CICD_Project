variable "alb-tg-name" {}
variable "alb-tg-port" {}
variable "alb-tg-protocol" {}
variable "vpc_id" {}
variable "ec2_instance_id" {}

output "tg-arn" {
  value = aws_lb_target_group.alb-tg.arn
}
#Traffic from loadbalamcer goes to port 80 of the Tg, then to port 8080 of the instance to use jenkins
resource "aws_lb_target_group" "alb-tg" {
  name = var.alb-tg-name
  port = var.alb-tg-port
  protocol = var.alb-tg-protocol #Target group's protocol -> HTTP(80)
  vpc_id = var.vpc_id 

  health_check{
    path = "/login"
    port = 8080
    healthy_threshold = 6
    unhealthy_threshold = 2
    timeout = 2
    interval = 5
    matcher = "200"
  }
}

#Target Group attachement
resource "aws_lb_target_group_attachment" "alb-tg-attachement" {
  target_group_arn = aws_lb_target_group.alb-tg.arn
  target_id = var.ec2_instance_id
  port = 8080 #Instance Port 8080 to use jenkins
}