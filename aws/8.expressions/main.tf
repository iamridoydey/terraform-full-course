resource "aws_instance" "prite_ec2" {
  ami   = var.ubuntu_ami
  count = var.instance_count

  instance_type = var.environment == "dev" ? tolist(var.instance_type)[0] : tolist(var.instance_type)[1]
  tags = {
    Name = "HelloWorld"
  }
}


resource "aws_security_group" "prite_sg" {
  name = "prite_sg"

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }

  }
}
