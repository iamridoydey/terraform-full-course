# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source      = "./modules/vpc"
  cidr_block  = var.cidr_block
  region      = var.region
  name_prefix = var.name_prefix
}


# subnets
module "subnets" {
  source        = "./modules/subnets"
  name_prefix   = var.name_prefix
  vpc_id        = module.vpc.vpc_id
  azs           = sort(data.aws_availability_zones.available.zone_ids)
  public_cidrs  = var.public_cidrs
  private_cidrs = var.private_cidrs
  subnet_tags   = var.subnet_tags

  # subnet won't be managed with k8s cluster
  public_subnet_tags = {
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  # subnet won't be managed with k8s cluster
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}
