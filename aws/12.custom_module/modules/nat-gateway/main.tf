resource "aws_network_interface" "multi-ip" {
  subnet_id   = aws_subnet.main.id
  private_ips = ["10.0.0.10", "10.0.0.11"]
}

resource "aws_eip" "eip" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.multi-ip.id
  associate_with_private_ip = "10.0.0.10"
}



resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.example.id
  subnet_id     = aws_subnet.example.id

  tags = {
    Name = "ngw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.example]
}


resource "aws_nat_gateway_eip_association" "example" {
  allocation_id  = aws_eip.example.id
  nat_gateway_id = aws_nat_gateway.example.id
}
