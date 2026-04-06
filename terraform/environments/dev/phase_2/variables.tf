variable "project_name" {
  description = "Prefix for all components"
  type = string
  default = "xoloforge"
}

variable "aws_region" {
  description = "Default AWS region"
  type = string
  default = "us-east-1"
}

variable "iam_role_policies_control_plane" {
  type = map(string)
  description = "Policies required for EKS Control Plane"
  default = {
    AmazonEKSClusterPolicy = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  }
}

variable "iam_role_policies_node_groups" {
  type = map(string)
  description = "Policies required for Node Groups"
  default = {
    AmazonEKSWorkerNodePolicy = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    AmazonEKS_CNI_Policy = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  }
}

variable "domain_name" {
  type = string
  default = "xoloforge.com"
  description = "Public DNS for the Xoloforge app"
}