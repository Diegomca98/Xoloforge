output "role_name" {
  value = module.iam_role_eks.name
  description = "EKS Role Name"
}

output "role_id" {
  value = module.iam_role_eks.unique_id
  description = "EKS Role ID"
}

output "role_arn" {
  value = module.iam_role_eks.arn
  description = "Role arn"
}