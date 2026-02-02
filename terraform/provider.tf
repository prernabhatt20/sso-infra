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
}

# Optional: backend for state file (S3 recommended for CI/CD)
terraform {
  backend "s3" {
  }
}
