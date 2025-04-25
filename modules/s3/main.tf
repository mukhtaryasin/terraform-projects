resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name # The name of the bucket. Must be unique across all existing bucket names in Amazon S3.
  tags = var.tags
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id # The name of the bucket to set versioning on.

  versioning_configuration {
    status = "Enabled" # The versioning state of the bucket.
  }
}

resource "aws_s3_bucket_acl" "public_access" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}


resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.this.id}",
                "arn:aws:s3:::${aws_s3_bucket.this.id}/*"
            ]
        }
    ]
}
POLICY
}