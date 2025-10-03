terraform {
  required_providers {
    aws = {                 # can use any type of provider as - abc 
      source = "hashicorp/aws"
      version = "6.14.1"
    }
  }
}


provider "aws" {
  region = "ap-south-1"
  
}

resource "random_id" "bucket_id" {
  byte_length = 8
  
}
resource "aws_s3_bucket" "my-bucket" {
  bucket = "my-tf-test-bucket-ayushman-80"
}

# Upload a local file to the S3 bucket
resource "aws_s3_object" "bucket" {
   bucket = aws_s3_bucket.my-bucket.bucket
   key    = "hi1.txt"
   source = "./hi1.txt"
}

output "name" {
  value = random_id.bucket_id.hex
}