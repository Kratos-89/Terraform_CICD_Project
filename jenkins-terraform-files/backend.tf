terraform {
  backend "s3"{
    bucket = "terra-project-3231"
    key = "terra-project-3231/jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}