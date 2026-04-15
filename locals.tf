locals {
  env_config = {
    default = {
      instance_count      = 1
      instance_type       = "t2.micro"
      enable_nat_gateway  = false
      enable_monitoring   = false
    }
    dev = {
      vpc_cidr             = "10.0.0.0/16"
      public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
      private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
      instance_count      = 1
      instance_type       = "t2.micro"
      enable_nat_gateway  = false
      enable_monitoring   = false
    }
    staging = {
      vpc_cidr             = "10.0.0.0/16"
      public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
      private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
      instance_count      = 1
      instance_type       = "t2.micro"
      enable_nat_gateway  = false
      enable_monitoring   = false
    }
    prod = {
      vpc_cidr             = "10.0.0.0/16"
      public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
      private_subnet_cidrs = ["10.1.3.0/24", "10.1.4.0/24"]
      instance_count      = 3
      instance_type       = "t2.small"
      enable_nat_gateway  = true
      enable_monitoring   = true
    }
  }

  config = lookup(local.env_config, terraform.workspace, local.env_config["default"])
}