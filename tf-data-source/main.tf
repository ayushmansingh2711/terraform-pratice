terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.18.0"
    }
  }
}

 provider "aws" {
   region = "ap-south-1"
 }

#  ami 
 
#  data "aws_ami" "name"{
#     most_recent = true
#     owners = ["amazon"]
#  }

#  output "aws_ami" {
#    value = data.aws_ami.name.id
#  }
  

  #security group

  data "aws_security_group" "name" {
    tags = {
        Name = "nginx-sg"
    }
  }

  output "aws_security_group" {
    value = data.aws_security_group.name.id
  }


  # vpc 
  data "aws_vpc" "name" {
    tags= {
        Name= "my-vpc"
    }
  }

  output "aws_vpc" {
    value = data.aws_vpc.name.id
  }

  # AZ 

  data "aws_availability_zones" "names" {
    state = "available"
  }

  output "aws_availability_zone" {
    value = data.aws_availability_zones.names
  }

  # account details

  data "aws_caller_identity" "current" {
  }

  output "aws_caller_identity" {
    value = data.aws_caller_identity.current
  }

  # subnet

  data "aws_subnet" "name" {
     filter {
        name = "vpc-id"
        values = [data.aws_vpc.name.id]
     }
     tags = {
       Name= "public-subnet"
     }
  }
    output "aws_subnet" {
        value = data.aws_subnet.name.id
    }