output "oidc_provider_arn" {
  value       = module.eks_cluster.oidc_provider_arn
  description = "EKS OIDC provider ARN"
}

output "cluster_name" {
  value       = module.eks_cluster.cluster_name
  description = "EKS cluster name"
}

output "cluster_endpoint" {
  value       = module.eks_cluster.cluster_endpoint
  description = "EKS cluster endpoint"
}

output "vpc_id" {
  value       = module.networking.vpc_id
  description = "VPC ID"
}