# Configure AWS provider
provider "aws" {
  region = local.config.aws.region
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
    
  }
}
