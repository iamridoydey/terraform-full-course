terraform {
  backend "s3" {
    bucket = "prite-tfstate-bucket"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


resource "aws_s3_bucket" "prite-example-bucket" {
  bucket = "prite-example-bucket"

  tags = {
    Name        = "prite example bucket"
    Environment = "Dev"
  }
}
