resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw"
  }
}


resource "aws_eip" "eip" {
  domain = "vpc"

  tags = {
    Name = "devops-nat-eip"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public-1a.id

  tags = {
    Name = "ngw"
  }

  depends_on = [aws_internet_gateway.igw]
}



resource "aws_subnet" "public-1a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "devops-public-1a"
  }
}

resource "aws_subnet" "public-1b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "devops-public-1b"
  }
}

resource "aws_subnet" "private-1a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "devops-private-1a"
  }
}

resource "aws_subnet" "private-1b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "devops-private-1b"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "devops-public-rt"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "devops-private-rt"
  }
}

resource "aws_route_table_association" "public-rt-assoc" {
  for_each = {
    public-a = aws_subnet.public-1a.id
    public-b = aws_subnet.public-1b.id
  }
  route_table_id = aws_route_table.public-rt.id
  subnet_id = each.value

  depends_on = [aws_route_table.public-rt]
}

resource "aws_route_table_association" "private-rt-assoc" {
  for_each = {
    private-a = aws_subnet.private-1a.id
    private-b = aws_subnet.private-1b.id
  }
  route_table_id = aws_route_table.private-rt.id
  subnet_id = each.value

  depends_on = [aws_route_table.private-rt]
}