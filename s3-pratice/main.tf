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

resource "random_id" "random" {
  byte_length = 8
}

resource "aws_s3_bucket" "s3-bucket" {
  bucket = "demo-s3-bucket-805233"
}

resource "aws_s3_object" "bucket-data" {
  bucket = aws_s3_bucket.s3-bucket.bucket
  source = "./hello.txt"
  key = "hello1.txt"
}

output "name" {
  value = random_id.random.id
}