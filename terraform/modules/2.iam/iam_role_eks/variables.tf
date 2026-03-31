    variable "iam_role_name" {
    type = string
    description = "IAM Role name for EKS differentiation"
    }

    variable "iam_role_principal" {
    type = list(string)
    description = "Applicable principle (eks.amazonaws.com for control plane | ec2.amazonaws.com for nodes)"
    }

    variable "iam_role_policies" {
    type = map(string)
    description = "Policies required for control plane and node groups"
    }

    variable "common_tags" {
    type = map(string)
    description = "Tags applied to all resources"
    default = {}
    }