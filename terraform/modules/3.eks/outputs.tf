output "cluster_name" {
  value = module.eks.cluster_name
  description = "Xoloforge EKS Cluster Name"
}

output "cluster_id" {
  value = module.eks.cluster_id
  description = "Xoloforge EKS Cluster ID"
}

output "eks_oidc_provider" {
  value = module.eks.oidc_provider
  description = "Xoloforge EKS OIDC Provider"
}

output "eks_oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
  description = "Xoloforge EKS OIDC Provider ARN"
}
