terraform {
  required_providers {
    aws = {                 # can use any type of provider as - abc 
      source = "hashicorp/aws"
      version = "6.14.1"
    }
 }
    backend "s3" {
        bucket = "myfirst-terraform-bucket-12345"
        key    = "gterraform.tfstate"
        region = "ap-south-1"
        encrypt = true
}
}
provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "myinstance" {
  ami           = "ami-01b6d88af12965bb6"
  instance_type = "t2.micro"
  
}