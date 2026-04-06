module "eks-blueprints-addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "1.23.0"

  cluster_name = var.cluster_name
  cluster_endpoint = var.cluster_endpoint
  cluster_version = var.cluster_version
  oidc_provider_arn = var.oidc_provider_arn

  enable_aws_load_balancer_controller = true
  enable_cert_manager = true
  enable_external_secrets = true
  enable_external_dns = true

  external_dns_route53_zone_arns = [var.hosted_zone_arn]
}
