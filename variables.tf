variable "aws_region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "eu-north-1"
}

variable "bucket_name" {
  description = "Base name for the S3 bucket (will have random suffix added)"
  type        = string
  default     = "terraform-static-site"
}
