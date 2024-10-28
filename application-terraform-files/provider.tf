terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # Specify the version you want to use
    }
  }

  #required_version = "<= 5.71.0"  # Specify the Terraform version you want to use
}

provider "aws" {
  region = "us-east-1"
  # shared_credentials_files = ["/Users/ravin/.aws/credentials"]
}