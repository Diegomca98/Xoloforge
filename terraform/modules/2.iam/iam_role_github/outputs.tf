output "oidc_provider_arn" {
  value = module.github_oidc.oidc_provider_arn
  description = "OIDC provider ARN"
}

output "oidc_role" {
  description = "CICD GitHub role ARN."
  value       = module.github_oidc.oidc_role.arn
}