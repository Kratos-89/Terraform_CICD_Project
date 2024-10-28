output "Jenkins-page" {
  value = var.domain_name_jenkins
}

output "jenkins-instance-ip" {
  value = module.jenkins.ec2-instance-ip
}

output "ssh login"{
  value = module.jenkins.ec2-endpoint
}