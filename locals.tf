locals {
  ingress_rules = {
    "ssh" = {
      port        = 22
      description = "Ingress for SSH"
    }
    "http" = {
      port        = 80
      description = "Ingress for HTTP"
    }
    "https" = {
      port        = 443
      description = "Ingress for HTTPS"
    }
  }
  env_config = {
    default = {
      vpc_cidr             = "10.0.0.0/16"
      public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
      private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
      instance_count      = 1
      instance_type       = "t2.micro"
      enable_nat_gateway  = false
      enable_monitoring   = false

      # allows SSH for debugging
      ingress_rules = {
        "ssh"   = { port = 22,  description = "SSH for dev" }
        "http"  = { port = 80,  description = "HTTP" }
        "https" = { port = 443, description = "HTTPS" }
      }
    }
    dev = {
      vpc_cidr             = "10.0.0.0/16"
      public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
      private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
      instance_count      = 1
      instance_type       = "t2.micro"
      enable_nat_gateway  = false
      enable_monitoring   = false

      # Dev allows SSH for debugging
      ingress_rules = {
        "ssh"   = { port = 22,  description = "SSH for dev" }
        "http"  = { port = 80,  description = "HTTP" }
        "https" = { port = 443, description = "HTTPS" }
      }
    }
    staging = {
      vpc_cidr             = "10.0.0.0/16"
      public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
      private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
      instance_count      = 1
      instance_type       = "t2.micro"
      enable_nat_gateway  = false
      enable_monitoring   = false

      # Staging allows SSH for debugging
      ingress_rules = {
        "ssh"   = { port = 22,  description = "SSH for staging" }
        "http"  = { port = 80,  description = "HTTP" }
        "https" = { port = 443, description = "HTTPS" }
      }
    }
    prod = {
      vpc_cidr             = "10.1.0.0/16"
      public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
      private_subnet_cidrs = ["10.1.3.0/24", "10.1.4.0/24"]
      instance_count      = 3
      instance_type       = "t2.small"
      enable_nat_gateway  = true
      enable_monitoring   = true

      # Production does not allow SSH
      ingress_rules = {
        "http"  = { port = 80,  description = "HTTP" }
        "https" = { port = 443, description = "HTTPS" }
      }
    }
  }

  config = lookup(local.env_config, terraform.workspace, local.env_config["default"])
}