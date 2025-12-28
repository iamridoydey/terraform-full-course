
variable "ubuntu_ami" {
  description = "AMI ID for Ubuntu"
  type        = string
  default     = "ami-0ecb62995f68bb549"
}


variable "instance_type" {
  description = "Define instance type"
  type        = set(string)
  default     = ["t3.micro", "t3.small", "c7i-flex.large", "m7i-flex.large"]
}

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
  type = list(map(string))

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
