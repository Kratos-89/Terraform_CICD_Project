variable "domain_name"{}
variable "hosted_zone_id" {} 

output "acm-cerf"{
  value = aws_acm_certificate.req_cerf.arn
}

resource "aws_acm_certificate" "req_cerf" {
  domain_name       = var.domain_name #Requsting certificate with for the name jenkins.ravin.store
  validation_method = "DNS"

  tags = {
    Environment = "Project-Testing"
  }
  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_route53_record" "validation" { #Various domain validation options
  for_each = {
    for dvo in aws_acm_certificate.req_cerf.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = var.hosted_zone_id # replace with your Hosted Zone ID of the domain ravin.store
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}