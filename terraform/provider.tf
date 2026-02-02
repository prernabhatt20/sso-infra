# Configure AWS provider
provider "aws" {
  region = var.aws_region
}

# Terraform required version
terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "aws-s3-bucket-github"  
    key    = "terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }

}


