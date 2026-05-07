variable "name_prefix" {
  description = "Name prefix"
  type        = string
}

variable "vpc_id" {
  description = "Vpc id"
  type        = string
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
}

variable "public_cidrs" {
  description = "Public subnet cidrs"
  type        = list(string)
}

variable "private_cidrs" {
  description = "Private subnet cidrs"
  type        = list(string)
}

variable "subnet_tags" {
  description = "Common subnet tags"
  type        = map(string)
}

variable "public_subnet_tags" {
  description = "Public subnet tags"
  type        = map(string)
}


variable "private_subnet_tags" {
  description = "Private subnet tags"
  type        = map(string)
}




