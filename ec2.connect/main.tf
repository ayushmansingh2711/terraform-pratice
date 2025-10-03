terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.15.0"
    }
  }
}

provider "aws" {
  region = var.region
  
}

resource "aws_instance" "myinstance" {
  ami = "ami-01b6d88af12965bb6"
  instance_type = "t2.micro"

}