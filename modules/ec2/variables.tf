variable "instance_count" {
  description = "Number of EC2 instances to deploy"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"

  validation {
    condition     = contains(["t2.micro", "t2.small"], var.instance_type)
    error_message = "Invalid instance type."
  }
}

variable "enable_monitoring" {
  description = "Enable detailed CloudWatch monitoring"
  type        = bool
}

variable "environment" {
  description = "Workspace environment name"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the instance will be launched"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to attach to the instance"
  type        = string
}