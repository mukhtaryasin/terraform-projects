variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  
}

variable "object_key" {
  default = "text.txt" # The name of the file in S3.
  description = "The name of the file in S3"
}

variable "file_path" {
  default = "./files/text.txt" # The path to the file on your local machine.
  description = "The path to the file on your local machine"
}
variable "content_type" {
  default = "text/plain" # The content type of the file.
  description = "The content type of the file"
}



variable "environment" {
  description = "The environment for the S3 bucket"
  type        = string
  default = "Dev"
}
