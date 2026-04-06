locals {
  environment = "dev"
  common_tags = {
    Project = var.project_name
    Environment = local.environment
    ManagedBy = "Terraform"
    Repository = "Xoloforge"
    DeploymentPhase = "Phase 2"
  }
}

/**********************/
/******** Helm ********/
/**********************/
resource "aws_route53_zone" "xoloforge" {
  name = var.domain_name
}

module "k8s_helm_addons" {
  source = "../../../modules/6.k8s-addons"

  cluster_name = module.eks_cluster.cluster_name
  cluster_endpoint = module.eks_cluster.cluster_endpoint
  cluster_version = module.eks_cluster.cluster_version
  oidc_provider_arn = module.eks_cluster.eks_oidc_provider_arn

  hosted_zone_arn = aws_route53_zone.xoloforge.arn
}

/**********************************/
/******** End Helm Section ********/
/**********************************/

/*************************/
/******** Route53 ********/
/*************************/

/*************************************/
/******** End Route53 Section ********/
/*************************************/




/*************************/
/******** Secrets ********/
/*************************/

/*************************************/
/******** End Secrets Section ********/
/*************************************/
