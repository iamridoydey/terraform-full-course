variable "vm_list" {
  description = "Virtual Machine list"
  type        = set(string)
  default     = ["pritedey-vm"]
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

variable "tags" {
  description = "Virtual Machine Tags"
  type        = map(string)
  default = {
    "environment" = "stagging"
    "Name"        = "ridoy-vm"
  }

}


variable "allowed_locations" {
  description = "All the allowed location"
  type        = list(string)
  default     = ["Korea Central", "West Asia", "Malasiya Central"]
}


variable "ip_configuration" {
  description = "Cidr range, ip addresses"
  type        = tuple([string, string, number])
  default     = ["21.0.0.0/16", "21.0.1.0", 24]
}


variable "security_rules" {
  description = "Security rule for the network security group"
  type = list(object({
    name                   = string
    priority               = number
    direction              = string
    access                 = string
    protocol               = string
    source_port_range      = string
    destination_port_range = string
  }))

  default = [
    {
      name                   = "Http"
      priority               = 100
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Tcp"
      source_port_range      = "80"
      destination_port_range = "80"
    },
    {
      name                   = "Https"
      priority               = 200
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Tcp"
      source_port_range      = "443"
      destination_port_range = "443"
    }
  ]
}
