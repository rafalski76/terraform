module "main_label" {
  source  = "cloudposse/label/null"
  version = "~> 0.25.0"

  namespace = var.namespace
  stage     = var.stage
  name      = var.name
}

data "aws_availability_zones" "this" {}

locals {
  azs = slice(data.aws_availability_zones.this.names, 0, var.vpc_az_count)
  _public_networks = [for az in local.azs : {
    name     = "public-${az}"
    new_bits = var.vpc_public_networks_new_bits
  }]
  _private_networks = [for az in local.azs : {
    name     = "private-${az}"
    new_bits = var.vpc_private_networks_new_bits
  }]
  _database_networks = [for az in local.azs : {
    name     = "database-${az}"
    new_bits = var.vpc_database_networks_new_bits
  }]
  _networks = flatten([local._public_networks, local._private_networks, local._database_networks])
}

module "subnet_addrs" {
  source = "hashicorp/subnets/cidr"

  base_cidr_block = var.vpc_cidr
  networks        = local._networks
}

locals {
  public_subnets = [for k, v in module.subnet_addrs.networks :
    v.cidr_block
    if substr(v.name, 0, 3) == "pub"
  ]
  private_subnets = [for k, v in module.subnet_addrs.networks :
    v.cidr_block
    if substr(v.name, 0, 3) == "pri"
  ]
  database_subnets = [for k, v in module.subnet_addrs.networks :
    v.cidr_block
    if substr(v.name, 0, 3) == "dat"
  ]
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name             = module.main_label.id
  cidr             = var.vpc_cidr
  azs              = local.azs
  public_subnets   = local.public_subnets
  private_subnets  = local.private_subnets
  database_subnets = local.database_subnets

  create_database_subnet_group = true
  enable_dns_hostnames         = true
  enable_dns_support           = true

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = { for k, v in module.main_label.tags : k => v if k != "Name" }
}