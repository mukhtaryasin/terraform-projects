# Terraform AWS Infrastructure Setup

This repository contains Terraform configurations to set up AWS infrastructure, including VPC, subnets, EC2 instances, IAM roles, and more. The setup is modularized for better reusability and scalability.

## Prerequisites

1. **Terraform**: Install Terraform from [Terraform's official website](https://www.terraform.io/downloads).
2. **AWS CLI**: Install and configure the AWS CLI with your credentials. Run `aws configure` to set up your access key, secret key, and default region.
3. **AWS Account**: Ensure you have an AWS account with sufficient permissions to create resources.

## Repository Structure

- **`modules/`**: Contains reusable Terraform modules for VPC, subnets, EC2, IAM, etc.
- **`main.tf`**: The main entry point for Terraform configuration.
- **`variables.tf`**: Defines input variables for the setup.
- **`outputs.tf`**: Outputs the created resources' details.
- **`terraform.tfvars`**: Contains values for the input variables.
- **`.terraform/`**: Auto-generated directory for Terraform state and provider plugins.

### Modules

1. **VPC Module**: Creates a VPC and an Internet Gateway.
2. **Subnets Module**: Creates public and private subnets with optional route tables.
3. **IAM Module**: Creates IAM roles and instance profiles.
4. **EC2 Module**: Launches EC2 instances with security groups and user data.

## Variables

The following variables are defined in `variables.tf` and can be customized in `terraform.tfvars`:

- **`aws_region`**: AWS region to deploy resources (e.g., `ap-southeast-2`).
- **`ami`**: AMI ID for EC2 instances.
- **`key_name`**: Name of the SSH key pair.
- **`s3_bucket_name`**: (Optional) S3 bucket for storing Terraform state.

## How to Run

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-repo/terraform-aws-setup.git
   cd terraform-aws-setup