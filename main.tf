provider "aws" {
  region = "ap-southeast-2" # Change this to your desired region
  
}
terraform {
  backend "s3" {
    bucket         = "bucket-4327" # The name of the S3 bucket for storing Terraform state
    key            = "terraform/terraform.tfstate" # The key for the state file in the S3 bucket
    region         = "ap-southeast-2" # The region where the S3 bucket is located
    
  }
}

# create a s3 bucket
# module "s3" {
#   source = "./modules/s3" # Path to your S3 module
#   bucket_name = "my-bucket-4327766-252" # The name of the S3 bucket
#   tags = {
#     Name        = "my-bucket-4327766-252"
#     Environment = "Dev"
#     Project     = "terraform-aws-projects"
#     Owner       = "mukhtar"
#   }
# }

# create a vpc
module "vpc" {
  source = "./modules/vpc" # Path to your VPC module
  vpc_name = "vpc-prac01-252" # The name of the VPC
  cidr_block = "10.1.0.0/16" # The CIDR block for the VPC
  azs = ["ap-southeast-2a", "ap-southeast-2b"] # Availability zones for the subnets
  public_subnet_cidrs = ["10.1.1.0/24", "10.1.2.0/24"] # CIDR blocks for public subnets
  private_subnet_cidrs = ["10.1.3.0/24", "10.1.4.0/24"] # CIDR blocks for private subnets
}

module "ec2" {
  source = "./modules/ec2" # Path to your EC2 module
  ami_id = "ami-0f6a1a6507c55c9a8" # The AMI ID for the EC2 instance
  instance_type = "t2.micro" # The instance type for the EC2 instance
  instance_count = 1 # The number of EC2 instances to create
  key_name = "my-key-pair-252" # The name of your key pair for SSH access
  subnet_ids = module.vpc.public_subnets # The ID of the subnet to launch the EC2 instance in
  security_group_id = module.vpc.security_group_id # The ID of the security group to associate with the EC2 instance
  user_data = file("./files/user_data.sh") 
}

