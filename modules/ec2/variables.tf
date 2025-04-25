variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  
}
variable "instance_type" {
  description = "The type of instance to create"
  type        = string
}
variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
}
variable "user_data" {
  description = "The user data to use for the EC2 instance"
  type        = string
  default     = ""
}
variable "environment" {
  description = "The environment for the EC2 instance (Dev, Test, Prod)"
  type        = string
  default     = "Dev"
  
}
variable "project_name" {
  description = "The name of the project"
  type        = string
  default = "" # The name of the project
}
variable "owner" {
  description = "The owner of the project"
  type        = string
  default = "" # The owner of the project
}
variable "subnet_ids" {
    description = "The IDs of the subnets"
    type        = list(string)
}
variable "instance_count" {
    description = "The number of instances to create"
    type        = number
    default     = 1 # The number of instances to create
  
}
variable "security_group_id" {
    description = "The ID of the security group to associate with the instance"
    type        = string
}