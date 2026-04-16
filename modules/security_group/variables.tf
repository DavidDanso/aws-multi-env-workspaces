variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created"
  type        = string
}

variable "ingress_rules" {
  description = "Map of ingress rules from locals"
  type = map(object({
    port        = number
    description = string
  }))
}