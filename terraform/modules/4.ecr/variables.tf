variable "ecr_repo_name" {
  type = string
  description = "Image repository name, each application service will have its own image repo"
}
variable "github_actions_role_arn" {
  type = string
  description = "Github Actions Role ARN"
}

variable "common_tags" {
  type = map(string)
  description = "Tags all resources have"
}

