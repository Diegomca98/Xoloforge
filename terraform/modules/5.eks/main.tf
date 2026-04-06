module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = var.cluster_name
  kubernetes_version = "1.33"

  # Public access enabled for portfolio/development purposes
  # In production: restrict to VPN CIDR or bastion only
  endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
  enable_irsa = true

  iam_role_arn = var.control_plane_iam_role_arn

  eks_managed_node_groups = {
    core_app = {
      instance_types = ["t3.medium"]
      min_size = 1
      max_size = 3
      desired_size = 2
      capacity_type = "ON_DEMAND"
      iam_role_arn = var.node_groups_iam_role_arn
      create = true
    },
    agents = {
      instance_types = ["g4dn.xlarge"]
      min_size = 0
      max_size = 3
      desired_size = 0
      capacity_type = "SPOT"
      iam_role_arn = var.node_groups_iam_role_arn
      create = var.enable_gpu_nodepool
      taints = [
        {
          key = "workload"
          value = "gpu-agent"
          effect = "NO_SCHEDULE"
        }
      ]
    }
  }

  tags = var.common_tags
}
