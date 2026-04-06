

terraform {
  required_version = ">= 1.7.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "3.1.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}