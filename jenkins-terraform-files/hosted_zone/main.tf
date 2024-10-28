variable "domain_name" {}
variable "dns_name" {}
variable "aws_lb_zone_id" {}


data "aws_route53_zone" "data"{
  name = "ravin.store"
  private_zone = false
}

resource "aws_route53_record" "lb_record"{
  zone_id = data.aws_route53_zone.data.zone_id #Our domain's hosted zone
  name    = var.domain_name #jenkins.ravin.store 
  type    = "A" # A Record creation
  alias{
    name = var.dns_name #Loadbalancer endpoint
    zone_id = var.aws_lb_zone_id #Load balancer zone id (Region)
    evaluate_target_health = true
  }
}

output "hosted_zone_id" {
  value = data.aws_route53_zone.data.zone_id #Zone id or dns zone id of ravin.store
}