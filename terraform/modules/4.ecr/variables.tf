variable "ecr_repo_name" {
  type = string
  description = "Image repository name, each application service will have its own image repo"
}

variable "common_tags" {
  type = map(string)
  description = "Tags all resources have"
}

