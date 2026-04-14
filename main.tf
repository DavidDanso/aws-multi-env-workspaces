module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
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