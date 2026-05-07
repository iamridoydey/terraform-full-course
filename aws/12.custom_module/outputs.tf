output "vpc_id" {
  value = module.vpc.vpc_id
}

# Public subnet ids
output "public_subnet_ids" {
  description = "Public subnet ids"
  value = module.subnets.public_subnet_ids
}

# Private subnet ids
output "private_subnet_ids" {
  description = "Private subnet ids"
  value = module.subnets.private_subnet_ids
}


output "azs" {
  value = sort(data.aws_availability_zones.available.zone_ids)
}
