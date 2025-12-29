variable "project_name" {
  default = "Project ALPHA Resource"
}

variable "all_ports" {
  default = "80 443 22"
}

variable "instance_types" {
  type = map(string)
  default = {
    "dev"      = "t3.micro"
    "stagging" = "t3.small"
    "prod"     = "c7i-flex.large"
  }
}

variable "env" {
  default = "stag"
}


variable "all_ami" {
  type = map(string)
  default = {
    "amazon_ubuntu" = "ami-068c0051b15cdb816"
    "ubuntu" = "ami-0ecb62995f68bb549"
    "macos" = "ami-0f8ce53a93ab42329"
    "windows" = "ami-06777e7ef7441deff"
  }

  validation {
    condition = alltrue([for ami in var.all_ami: length(ami) >= 8 && length(ami) <= 28 && substr(ami, 0, 4) == "ami-"])
    error_message = "All ami must have the length between 8-28 character and should include ami-"
  }
}

