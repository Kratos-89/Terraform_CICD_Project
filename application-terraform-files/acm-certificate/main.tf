variable "domain_name" {}
variable "hosted_zone_id" {}

output "acm-cerf-arn"{
  value = aws_acm_certificate.acm-cerf.arn
}

resource "aws_acm_certificate" "acm-cerf" {
  domain_name       = var.domain_name #app.ravin.store
  validation_method = "DNS"

  tags = {
    Environment = "Project-Testing"
  }

  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.acm-cerf.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = var.hosted_zone_id # replace with your Hosted Zone ID
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}