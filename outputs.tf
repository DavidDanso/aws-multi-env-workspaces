output "public_ips" {
  description = "The public IPs of the EC2 instances"
  value       = module.ec2.public_ips
}

output "public_dns" {
  description = "The public DNS names of the EC2 instances"
  value       = module.ec2.public_dns
}

output "ssh_connection_strings" {
  description = "SSH commands to connect to the EC2 instances"
  value       = module.ec2.ssh_connection_strings
}
