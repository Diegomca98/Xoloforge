module "github_oidc" {
  source  = "terraform-module/github-oidc-provider/aws"
  version = "~> 1"

  create_oidc_provider = true
  create_oidc_role     = true

  repositories = [
    "Diegomca98/Xoloforge:ref:refs/heads/main",
    "Diegomca98/Xoloforge:ref:refs/heads/develop"
  ]

  # TODO: Replace with scoped custom inline policies for prod:
  # - ECR: scope to xoloforge-* repositories only
  # - EKS: eks:DescribeCluster scoped to cluster ARN only
  oidc_role_attach_policies = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser",
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
  ]

  role_name = var.role_name

  tags = var.common_tags
}
