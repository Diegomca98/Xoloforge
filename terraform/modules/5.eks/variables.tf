variable "cluster_name" {
  type = string
  description = "EKS Cluster name"
}

variable "vpc_id" {
  type = string
  description = "VPC ID created on networking module"
}

variable "subnet_ids" {
  type = list(string)
  description = "Subnets that belong to the VPC"
}

variable "control_plane_iam_role_arn" {
  type = string
  description = "IAM Role ARN - Control Plane"
}

variable "node_groups_iam_role_arn" {
  type = string
  description = "IAM Role ARN - Node Groups"
}

variable "common_tags" {
  type = map(string)
  description = "Tags all resources have"
}

variable "enable_gpu_nodepool" {
  type = bool
  default = false
  description = "Create GPU Nodepool"
}