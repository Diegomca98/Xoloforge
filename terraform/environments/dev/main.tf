terraform {
  required_version = ">= 1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "xoloforge-tfstate-bkt"
    key = "dev/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "xoloforge-tf-locks"
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = local.common_tags
  }
}

locals {
  environment = "dev"
  common_tags = {
    Project = var.project_name
    Environment = local.environment
    ManagedBy = "Terraform"
    Repository = "Xoloforge"
  }
}

module "networking" {
  source = "../../modules/networking"

  project_name = var.project_name
  environment = local.environment
  vpc_cidr = "10.0.0.0/16"
  availability_zones = [ "us-east-1a", "us-east-1b" ]
  private_subnet_cidrs = [ "10.0.1.0/24", "10.0.2.0/24" ]
  public_subnet_cidrs = [ "10.0.101.0/24", "10.0.102.0/24" ]
  common_tags = local.common_tags
}