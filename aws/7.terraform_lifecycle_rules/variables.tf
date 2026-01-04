
variable "cidr_block" {
  description = "CIDR blocks"
  type        = list(string)
  default     = ["10.0.0.0/16", "11.0.0.0/16", "12.0.0.0/16"]
}


variable "tags" {
  description = "Map of tags"
  type        = map(string)
  default = {
    "Environment" = "dev",
    "Name"        = "prite"
  }
}

variable "meta_tag_args" {
  description = "Ec2 instance using meta arguments"
  type        = list(map(string))

  default = [
    {
      Environment = "dev",
      Name        = "Prite"
    },
    {
      Environment = "prod",
      Name        = "Ridoy"
    }
  ]
}


variable "ingress_value" {
  description = "Ingress from_port, protocol and to_port value"
  type        = tuple([number, string, number])
  default     = [443, "tcp", 443]
}


variable "ec2_instance_config" {
  type = object({
    instance_count = number,
    monitoring     = bool,
    region         = string
  })

  default = {
    instance_count = 1,
    monitoring     = true,
    region         = "us-east-1"
  }
}

variable "aws_ami_list" {
  description = "List of amazon machine image"
  type        = map(string)
  default = {
    "amazon-ubuntu" = "ami-068c0051b15cdb816"
    "ubuntu"        = "ami-0ecb62995f68bb549"
  }
}


variable "instance_type_list" {
  description = "Instance type list"
  type        = map(string)
  default = {
    "micro"  = "t3.micro"
    "small"  = "t3.small"
    "medium" = "c7i-flex.large"
    "large"  = "m7i-flex.large"
  }
}

variable "available_region" {
  description = "Available region list"
  type = set(string)
  default = [ "us-east-1", "us-east-2", "ap-south-1" ]
}


variable "availability_zones" {
  description = "Availability zone list"
  type = set(string)
  default = [ "us-east-1a", "us-east-1b" ]
}