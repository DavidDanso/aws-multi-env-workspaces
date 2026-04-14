locals {
  env_config = {
    default = {
      instance_count      = 1
      instance_type       = "t2.micro"
      enable_nat_gateway  = false
      enable_monitoring   = false
    }
    dev = {
      instance_count      = 1
      instance_type       = "t2.micro"
      enable_nat_gateway  = false
      enable_monitoring   = false
    }
    staging = {
      instance_count      = 1
      instance_type       = "t2.micro"
      enable_nat_gateway  = false
      enable_monitoring   = false
    }
    prod = {
      instance_count      = 3
      instance_type       = "t2.small"
      enable_nat_gateway  = true
      enable_monitoring   = true
    }
  }

  config = lookup(local.env_config, terraform.workspace, local.env_config["default"])
}