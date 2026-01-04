variable "aws_vpc" {}

data "aws_vpc" "vpc_name" {
  filter {
    name = "tag:Name"
    values = []
  }
}

resource "aws_subnet" "example_subnet" {
  vpc_id            = data.aws_vpc.vpc_name.id
  availability_zone = "us-west-2a"
  cidr_block        = cidrsubnet(data.aws_vpc.vpc_name, 4, 1)
}

resource "aws_instance" "prite_ec2" {
  ami   = var.ubuntu_ami
  subnet_id =
  private_ip = 
  count = var.instance_count

  tags = {
    Name = "HelloWorld"
  }
}

