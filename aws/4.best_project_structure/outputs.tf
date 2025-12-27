output "s3_arn" {
  value = aws_s3_bucket.prite-example-bucket.arn
}

output "vpc_arn" {
  value = aws_vpc.prite-vpc.arn
}