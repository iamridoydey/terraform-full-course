variable "vm_list" {
  description = "Virtual Machine list"
  type = set(string)
  default = [ "prite-vm", "ridoy-vm", "toma-vm" ]
}

variable "disk_size" {
  description = "Disk size"
  type        = number
  default     = 30
}

variable "vm_username" {
  description = "Virtual Machine Username"
  type        = string
  default     = "ubuntu"
}

variable "vm_tags" {
  description = "Virtual Machine Tags"
  type        = list(map(string))
  default = [
    {
      "environment" = "dev"
    },
    {
      "Name" = "prite-vm"
    }
  ]
}


variable "allowed_locations" {
  description = "All the allowed location"
  type = list(string)
  default = ["Korea Central", "West Asia", "Malasiya Central"]
}


variable "ip_configuration" {
  description = "Cidr range, ip addresses"
  type = tuple([ string, string, number ])
  default = [ "21.0.0.0/16", "21.0.1.0", 24 ]
}