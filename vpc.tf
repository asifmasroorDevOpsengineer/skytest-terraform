module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = var.vpc_name
  cidr = "${var.vpc_cidr_prefix}.0.0/16"

  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets = ["${var.vpc_cidr_prefix}.1.0/24", "${var.vpc_cidr_prefix}.2.0/24", "${var.vpc_cidr_prefix}.3.0/24"]
  public_subnets  = ["${var.vpc_cidr_prefix}.101.0/24", "${var.vpc_cidr_prefix}.102.0/24", "${var.vpc_cidr_prefix}.103.0/24"]
  #database_subnets = ["${var.vpc_cidr_prefix}.201.0/24", "${var.vpc_cidr_prefix}.202.0/24", "${var.vpc_cidr_prefix}.203.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform = "true"
    Name      = var.vpc_name
  }
}