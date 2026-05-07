data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_security_group" "sg" {
  name        = "devops-sg"
  description = "Allow SSH traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "devops_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = "pritedey-aws-login"
  subnet_id     = aws_subnet.public-1a.id
  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.sg.id
  ]

  user_data = file("${path.module}/userdata.sh")

  root_block_device {
    volume_type = "gp3"
    volume_size = 15
  }

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "devops-instance"
  }
}
