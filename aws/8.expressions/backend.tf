terraform {
  backend "s3" {
    bucket = "prite-tfstate-bucket"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
}