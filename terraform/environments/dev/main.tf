locals {
  environment = "dev"
  common_tags = {
    Project = var.project_name
    Environment = local.environment
    ManagedBy = "Terraform"
    Repository = "Xoloforge"
  }
}

/*********************/
/******** VPC ********/
/*********************/
module "networking" {
  source = "../../modules/1.networking"

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

/*********************/
/******** IAM ********/
/*********************/
module "eks_role_control_plane" {
  source = "../../modules/2.iam/iam_role_eks"

  iam_role_name = "${var.project_name}-${local.environment}-control-plane-role"
  iam_role_principal = ["eks.amazonaws.com"]
  iam_role_policies = var.iam_role_policies_control_plane
}
module "eks_role_general_node_group" {
  source = "../../modules/2.iam/iam_role_eks"
  
  iam_role_name = "${var.project_name}-${local.environment}-node-group-role"
  iam_role_principal = ["ec2.amazonaws.com"]
  iam_role_policies = var.iam_role_policies_node_groups
}

/*********************************/
/******** End IAM Section ********/
/*********************************/





/*********************/
/******** ECR ********/
/*********************/

/*********************************/
/******** End ECR Section ********/
/*********************************/





/*********************/
/******** EKS ********/
/*********************/

module "eks_cluster" {
  source = "../../modules/3.eks/"

  cluster_name = "${var.project_name}-${local.environment}-eks-cluster"
  vpc_id     = module.networking.vpc_id
  subnet_ids = module.networking.private_subnet_ids

  common_tags = local.common_tags
}

/*********************************/
/******** End EKS Section ********/
/*********************************/





/*********************/
/******** GPU ********/
/*********************/

/*********************************/
/******** End GPU Section ********/
/*********************************/





/*************************/
/******** Route53 ********/
/*************************/

/*************************************/
/******** End Route53 Section ********/
/*************************************/





/**********************/
/******** Helm ********/
/**********************/

/**********************************/
/******** End Helm Section ********/
/**********************************/





/*************************/
/******** Secrets ********/
/*************************/

/*************************************/
/******** End Secrets Section ********/
/*************************************/
