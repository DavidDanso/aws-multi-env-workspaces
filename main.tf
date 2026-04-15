module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = local.config.vpc_cidr
  public_subnet_cidrs  = local.config.public_subnet_cidrs
  private_subnet_cidrs = local.config.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "security_group" {
  source        = "./modules/security_group"
  vpc_id        = module.vpc.vpc_id
  ingress_rules = local.config.ingress_rules
}

module "ec2" {
  source            = "./modules/ec2"
  instance_count    = local.config.instance_count
  instance_type     = local.config.instance_type
  enable_monitoring = local.config.enable_monitoring
  environment       = terraform.workspace
  ami_id            = var.ami_id
  key_name          = var.key_name
  subnet_id         = module.vpc.public_subnet_ids[0]
  security_group_id = module.security_group.security_group_id
}

resource "aws_eip" "nat" {
  count  = local.config.enable_nat_gateway ? 1 : 0
  domain = "vpc"

  tags = {
    Name = "nat-eip-${terraform.workspace}"
  }
}

resource "aws_nat_gateway" "main" {
  count         = local.config.enable_nat_gateway ? 1 : 0
  allocation_id = aws_eip.nat[0].id
  subnet_id     = module.vpc.public_subnet_ids[0]

  tags = {
    Name = "nat-gateway-${terraform.workspace}"
  }

  depends_on = [module.vpc]
}