# VPC variables
variable "cidr_block" {
  description = "Valid cidr value"
  type        = string
  default     = "10.0.0.0/16"
}


variable "name_prefix" {
  description = "Name prefix"
  type        = string
  default     = ""
}


variable "region" {
  description = "Region"
  type        = string
  default     = "us-east-1"
}


# Subnets variables
variable "public_cidrs" {
  description = "Public subnet cidrs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_cidrs" {
  description = "Private subnet cidrs"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
}

variable "subnet_tags" {
  description = "Common subnet tags"
  type        = map(string)
  default = {
    "project" : "3 tier app",
    "author" : "iamridoydey"
  }
}



# Eks cluster name
variable "cluster_name" {
  description = "Eks cluster name"
  type = string
  default = "voting-app-cluster"
}
