provider "aws" {
  region = local.region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name = local.name
  cidr = "10.0.0.0/16"

  azs              = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  database_subnets = ["10.0.11.0/24", "10.0.12.0/24", "10.0.3.0/24"]
  public_subnets   = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]

  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = false

  manage_default_network_acl = true
  # public_dedicated_network_acl    = true
  # private_dedicated_network_acl   = true
  # database_dedicated_network_acl  = true

  # public_inbound_acl_rules      = concat(local.network_acls["default_inbound"], local.network_acls["public_inbound"])
  # public_outbound_acl_rules     = concat(local.network_acls["default_outbound"], local.network_acls["public_outbound"])
  # private_inbound_acl_rules     = concat(local.network_acls["default_inbound"], local.network_acls["public_inbound"])
  # private_outbound_acl_rules    = concat(local.network_acls["default_outbound"], local.network_acls["public_outbound"])
  # database_inbound_acl_rules    = concat(local.network_acls["default_inbound"], local.network_acls["public_inbound"])
  # database_outbound_acl_rules   = concat(local.network_acls["default_outbound"], local.network_acls["public_outbound"])

  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_ipv6          = false

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false #set to true for one per AZ

  tags = local.tags

  vpc_tags = {
    Name = local.name
  }
}