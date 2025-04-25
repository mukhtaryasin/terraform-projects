resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name # The name of the bucket. Must be unique across all existing bucket names in Amazon S3.
  tags = {
    environment = var.environment # Add your tags here
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id # The name of the bucket to set versioning on.

  versioning_configuration {
    status = "Enabled" # The versioning state of the bucket.
  }
}

resource "aws_s3_object" "upload-file" {
  bucket = aws_s3_bucket.this.id # The name of the bucket to upload the file to.
  key    = var.object_key # The name of the file in S3.
  source = var.file_path # The path to the file on your local machine.
  # Optional: Set the content type of the file
  content_type = var.content_type
  
}