output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.ec2.id # The ID of the EC2 instance.
  
}

output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.ec2.public_ip
}
