terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.27.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_s3_bucket" "prite-tfstate-bucket" {
  bucket = "prite-tfstate-bucket"

  tags = {
    Name        = "prite tfstate bucket"
    Environment = "Dev"
  }
}