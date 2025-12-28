output "prite_ec2_dns_names" {
  value = aws_instance.prite_ec2[*].public_dns
}

output "vpc_arn" {
  value = aws_vpc.prite_vpc.arn
}