output "bucket_id" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.this.bucket # The name of the bucket.
  
}