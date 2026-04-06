locals {
  environment = "dev"
  common_tags = {
    Project = var.project_name
    Environment = local.environment
    ManagedBy = "Terraform"
    Repository = "Xoloforge"
    DeploymentPhase = "Phase 1"
  }
}

/*********************/
/******** VPC ********/
/*********************/
module "networking" {
  source = "../../../modules/1.networking"

  project_name = var.project_name
  environment = local.environment
  vpc_cidr = "10.0.0.0/16"
  availability_zones = [ "us-east-1a", "us-east-1b" ]
  private_subnet_cidrs = [ "10.0.1.0/24", "10.0.2.0/24" ]
  public_subnet_cidrs = [ "10.0.101.0/24", "10.0.102.0/24" ]
  common_tags = local.common_tags
}

/*********************************/
/******** End VPC Section ********/
/*********************************/



/***************************/
/******** IAM - EKS ********/
/***************************/
module "eks_role_control_plane" {
  source = "../../../modules/2.iam/iam_role_eks"

  iam_role_name = "${var.project_name}-${local.environment}-control-plane-role"
  iam_role_principal = ["eks.amazonaws.com"]
  iam_role_policies = var.iam_role_policies_control_plane
  common_tags = local.common_tags
}
module "eks_role_general_node_group" {
  source = "../../../modules/2.iam/iam_role_eks"
  
  iam_role_name = "${var.project_name}-${local.environment}-node-group-role"
  iam_role_principal = ["ec2.amazonaws.com"]
  iam_role_policies = var.iam_role_policies_node_groups
  common_tags = local.common_tags
}

/*************************************/
/******** End IAM EKS Section ********/
/*************************************/



/************************/
/***** IAM - Github *****/
/************************/

module "github_oidc" {
  source = "../../../modules/2.iam/iam_role_github"

  role_name = "xoloforge-github-actions-role"
  common_tags = local.common_tags
}

/**********************************/
/***** End IAM Github Section *****/
/**********************************/



/*********************/
/******** ECR ********/
/*********************/

module "ecr_builder" {
  source = "../../../modules/4.ecr"

  ecr_repo_name = "xoloforge-builder-service"
  github_actions_role_arn = module.ecr_builder.repository_arn
  common_tags = local.common_tags
}

module "ecr_improver" {
  source = "../../../modules/4.ecr"

  ecr_repo_name = "xoloforge-improver-service"
  github_actions_role_arn = module.ecr_improver.repository_arn
  common_tags = local.common_tags
}

module "ecr_scout" {
  source = "../../../modules/4.ecr"

  ecr_repo_name = "xoloforge-scout-service"
  github_actions_role_arn = module.ecr_scout.repository_arn
  common_tags = local.common_tags
}

module "mcp" {
  source = "../../../modules/4.ecr"

  ecr_repo_name = "xoloforge-mcp-service"
  github_actions_role_arn = module.mcp.repository_arn
  common_tags = local.common_tags
}


/*********************************/
/******** End ECR Section ********/
/*********************************/



/*********************/
/******** EKS ********/
/*********************/

module "eks_cluster" {
  source = "../../../modules/3.eks/"

  cluster_name = "${var.project_name}-${local.environment}-eks-cluster"
  vpc_id     = module.networking.vpc_id
  subnet_ids = module.networking.private_subnet_ids

  common_tags = local.common_tags
}

/*********************************/
/******** End EKS Section ********/
/*********************************/



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
  oidc_provider_arn = module.eks.oidc_provider_arn

  hosted_zone_arn = aws_route53_zone.xoloforge.arn
}

/**********************************/
/******** End Helm Section ********/
/**********************************/