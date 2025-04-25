output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id # The ID of the VPC.
  
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public[*].id # List of IDs of public subnets.
  
}
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private[*].id # List of IDs of private subnets.
  
}
output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.this.id # The ID of the security group.
  
}