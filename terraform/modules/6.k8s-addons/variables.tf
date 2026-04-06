variable "cluster_name" {
  type = string
  description = "EKS Cluster Name"
}

variable "cluster_endpoint" {
  type = string
  description = "EKS Cluster Endpoint"
}

variable "cluster_version" {
  type = string
  description = "EKS Cluster Version"
}
  #module.eks.oidc_provider_arn
variable "oidc_provider_arn" {
  type = string
  description = "EKS OICD Provider ARN"
}

variable "hosted_zone_arn" {
  type = string
  description = "Route53 Hosted Zone ARN"
}