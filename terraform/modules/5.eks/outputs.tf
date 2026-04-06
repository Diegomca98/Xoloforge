output "cluster_name" {
  value = module.eks.cluster_name
  description = "Xoloforge EKS Cluster Name"
}

output "cluster_id" {
  value = module.eks.cluster_id
  description = "Xoloforge EKS Cluster ID"
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
  description = "EKS Cluster Endpoint"
}

output "cluster_version" {
  value = module.eks.cluster_version
  description = "EKS Cluster Version"
}

output "eks_oidc_provider" {
  value = module.eks.oidc_provider
  description = "Xoloforge EKS OIDC Provider"
}

output "eks_oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
  description = "Xoloforge EKS OIDC Provider ARN"
}

output "node_iam_role_arn" {
  value = module.eks.node_iam_role_arn
  description = "EKS Auto node IAM role ARN"
}

output "eks_managed_node_groups" {
  value = module.eks.eks_managed_node_groups
  description = "Map of attribute maps for all EKS managed node groups created"
}