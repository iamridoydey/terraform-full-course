
resource "aws_vpc" "prite_vpc" {
  cidr_block = var.cidr_block[0]

  tags = {
    Environment = local.env
    Name        = "${var.tags.Name}_vpc"
  }
}

# Using count meta argument
resource "aws_instance" "prite_ec2" {
  ami                    = var.ubuntu_ami
  count                  = 2
  instance_type          = tolist(var.instance_type)[0]
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  tags = var.meta_tag_args[count.index]
}


# Using for-each meta argument
resource "aws_s3_bucket" "prit_bucket" {
  for_each = { for obj in var.meta_tag_args : obj.Name => obj }

  bucket = "${each.key}_iamridoydey_bucket"

  tags = {
    Environment = each.value.Environment
    Name        = each.value.Name
  }
}



resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.prite_vpc.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.prite_vpc.cidr_block
  from_port         = var.ingress_value[0]
  ip_protocol       = var.ingress_value[1]
  to_port           = var.ingress_value[2]
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.prite_vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
