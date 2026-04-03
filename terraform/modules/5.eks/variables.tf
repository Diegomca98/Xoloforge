variable "cluster_name" {
  type = string
  description = "EKS Cluster name"

variable "vpc_id" {
  type = string
  description = "VPC ID created on networking module"
}

variable "subnet_ids" {
  type = list(string)
  description = "Subnets that belong to the VPC"
}

variable "common_tags" {
  type = map(string)
  description = "Tags all resources have"
}
