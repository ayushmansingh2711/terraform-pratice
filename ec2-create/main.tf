terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.16.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "my_ec2" {
  ami = "ami-02d26659fd82cf299"
  instance_type = "t2.micro"
  tags ={
    name = "MyFirst"
  }
}