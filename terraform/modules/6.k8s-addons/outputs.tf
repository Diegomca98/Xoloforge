output "aws_load_balancer_controller" {
  value = module.eks-blueprints-addons.aws_load_balancer_controller
  description = "Map of attributes of the Helm release and IRSA created"
}

output "external_secrets" {
  value = module.eks-blueprints-addons.external_secrets
  description = "Map of attributes of the Helm release and IRSA created"
}

output "cert_manager" {
  value = module.eks-blueprints-addons.cert_manager
  description = "Map of attributes of the Helm release and IRSA created"
}