output "ec2_public_ips" {
  description = "Public IPs of the EC2 instances"
  value       = module.ec2.instance_public_ip # Public IPs of the EC2 instances.
  
}