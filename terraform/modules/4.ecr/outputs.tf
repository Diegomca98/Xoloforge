output "repository_arn" {
  value = module.ecr.repository_arn
  description = "Repository ARN"
}

output "repository_name" {
  value = module.ecr.repository_name
  description = "Name of the ECR repo"
}

output "repository_registry_id" {
  value = module.ecr.repository_registry_id
  description = "The registry ID where the repository was created"
}

output "repository_url" {
  value = module.ecr.repository_url
  description = "The URL of the repository"
}
