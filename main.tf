provider "aws" {
  region = local.region
}

locals {
  name   = "sindri"
  region = "eu-north-1"

  tags = {
    Example    = local.name
    GitLabRepo = "terraform-aws-vpc"
    GitLabOrg  = "AWS-Automation"
  }
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name = local.name
  cidr = "10.0.0.0/16"

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  database_subnets= ["10.0.11.0/24", "10.0.12.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]

  enable_ipv6 = true

  enable_nat_gateway = false
  single_nat_gateway = true

  tags = local.tags

  vpc_tags = {
    Name = local.name
  }
}