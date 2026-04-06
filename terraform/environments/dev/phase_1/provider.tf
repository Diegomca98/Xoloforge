provider "aws" {
  region = var.aws_region
  default_tags {
    tags = local.common_tags
  }
}

provider "helm" {
  kubernetes = {
    # host                   = module.eks.cluster_endpoint
    # cluster_ca_certificate = module.eks.cluster_ca_certificate
    # token                  = module.eks.cluster_token
  }
}