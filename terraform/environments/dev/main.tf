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