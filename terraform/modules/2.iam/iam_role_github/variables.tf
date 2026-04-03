variable "common_tags" {
  type = map(string)
  description = "Tags applied to all resources"
  default = {}
}

variable "role_name" {
  type        = string
  description = "Name of the GitHub Actions OIDC IAM role"
  default     = "xoloforge-github-actions-role"
}
