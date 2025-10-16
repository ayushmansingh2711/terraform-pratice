terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.16.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}
 # unique bucket name 
 resource "random_id" "random" {
   byte_length = 4
 }

# create a unique bucket 

resource "aws_s3_bucket" "demo-bucket" {
  bucket = "demo-bucket-${random_id.random.hex}"

  tags = {
    Name = "Demo static site "
  }
}


# Allow public access
resource "aws_s3_bucket_public_access_block" "demo" {
  bucket = aws_s3_bucket.demo-bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


# Public read only policy 
resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.demo-bucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = "*",
        Action   = "s3:GetObject",
        Resource = "${aws_s3_bucket.demo-bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "demo-website" {
  bucket = aws_s3_bucket.demo-bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# upload index.html 

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.demo-bucket.bucket
  key    = "index.html"
  source = "./index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "style" {
  bucket = aws_s3_bucket.demo-bucket.bucket
  key    = "./css/vendor.css"
  source = "./css/vendor.css"
  content_type = "text/css"
}


# Enable static website host 


resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.demo-bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.demo-bucket.bucket
}

output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.website.website_endpoint
}
