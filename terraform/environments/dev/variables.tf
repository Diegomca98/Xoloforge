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