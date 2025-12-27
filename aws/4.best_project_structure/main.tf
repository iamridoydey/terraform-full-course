
resource "aws_vpc" "prite-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Environment = local.env
  }
}

resource "aws_s3_bucket" "prite-example-bucket" {
  bucket = "prite-example-bucket"

  tags = {
    Name        = "prite example bucket"
    Environment = local.env
  }
}
