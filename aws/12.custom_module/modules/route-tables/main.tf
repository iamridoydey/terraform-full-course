resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.private_route_cidr
    nat_gateway_id = var.ngw_id
  }


  tags = {
    Name = "private-rt"
  }
}


resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.public_route_cidr
    gateway_id = var.igw_id
  }


  tags = {
    Name = "public-rt"
  }
}