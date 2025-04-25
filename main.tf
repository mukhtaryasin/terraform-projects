provider "aws" {
  region = "ap-southeast-2" # Change this to your desired region
  
}

module "s3_bucket" {
  source = "./modules/s3" # Path to your S3 module
  bucket_name = var.bucket_name # The name of the S3 bucket
}