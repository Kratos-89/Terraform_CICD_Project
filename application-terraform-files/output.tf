output "application" {
  value = var.domain_name
}

output "ec2-Instance-IP" {
  value = module.application-instance.instance_ip
}