variable "vpc_id" {
  description = "Vpc id"
  type        = string
}

variable "private_route_cidr" {
  description = "Private route cidr"
  type        = string
}


variable "public_route_cidr" {
  description = "Public route cidr"
  type        = string
}


variable "igw_id" {
  description = "Internet Gateway Id"
  type        = string
}


variable "ngw_id" {
  description = "Nat Gateway Id"
  type        = string
}
