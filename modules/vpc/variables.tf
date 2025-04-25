variable "vpc_name" {
    description = "The name of the VPC"
    type        = string
}
variable "cidr_block" {
    description = "The CIDR block for the VPC"
    type        = string
}
variable "azs" {
    description = "The availability zones for the VPC"
    type        = list(string)
}
variable "public_subnet_cidrs" {
    description = "The CIDR blocks for the public subnets"
    type        = list(string)
}
variable "private_subnet_cidrs" {
    description = "The CIDR blocks for the private subnets"
    type        = list(string)
}
variable "allowed_ips" {
    description = "the IP addresses that are allowed to access the VPC"
    type        = list(string)
    default = [ "0.0.0.0/0" ]# Allow all IPs to access the VPC
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
