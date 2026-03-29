output "vpc_name" {
  value = module.vpc.name
  description = "VPC Name"
}

output "vpc_id" {
  value = module.vpc.vpc_id
  description = "VPC ID"
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
  description = "List of VCP Public Subnet IDs"
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
  description = "List of VCP Private Subnet IDs"
}