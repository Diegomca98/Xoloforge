// EKS Cluster and Nodes - Roles
module "iam_role_eks" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"

  name = var.iam_role_name

  trust_policy_permissions = {
    TrustRoleAndServiceToAssume = {
      actions = [
        "sts:AssumeRole",
      ]
      principals = [{
        type = "Service"
        identifiers = var.iam_role_principal
      }]
    }
  }

  policies = var.iam_role_policies

  tags = var.common_tags
}