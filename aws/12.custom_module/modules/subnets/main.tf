resource "aws_subnet" "public" {
  vpc_id            = var.vpc_id
  count             = length(var.public_cidrs)
  cidr_block        = var.public_cidrs[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.subnet_tags,
    var.public_subnet_tags,
    {
      Name = "${var.name_prefix}-public-subnet-${var.azs[count.index]}",
      Type = "public"
    }
  )
}


resource "aws_subnet" "private" {
  vpc_id            = var.vpc_id
  count             = length(var.public_cidrs)
  cidr_block        = var.public_cidrs[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.subnet_tags,
    var.private_subnet_tags,
    {
      Name = "${var.name_prefix}-private-subnet-${var.azs[count.index]}",
      Type = "private"
    }
  )
}