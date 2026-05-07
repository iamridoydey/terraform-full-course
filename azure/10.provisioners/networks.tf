# Resource group
resource "azurerm_resource_group" "provisioner_rg" {
  name     = "provisioner-resources"
  location = var.allowed_locations[0]
}

resource "azurerm_virtual_network" "provisioner_vnet" {
  name                = "provisioner_vnet"
  address_space       = [element(var.ip_configuration, 0)]
  location            = azurerm_resource_group.provisioner_rg.location
  resource_group_name = azurerm_resource_group.provisioner_rg.name
}

resource "azurerm_subnet" "provisioner_subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.provisioner_rg.name
  virtual_network_name = azurerm_virtual_network.provisioner_vnet.name
  address_prefixes     = ["${element(var.ip_configuration, 1)}/${element(var.ip_configuration, 2)}"]
}

resource "azurerm_network_interface" "provisioner_nic" {
  name                = "provisioner_nic"
  location            = azurerm_resource_group.provisioner_rg.location
  resource_group_name = azurerm_resource_group.provisioner_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.provisioner_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.provisioner_pip.id
  }
}

resource "azurerm_public_ip" "provisioner_pip" {
  name                = "provisioner-pip"
  resource_group_name = azurerm_resource_group.provisioner_rg.name
  location            = azurerm_resource_group.provisioner_rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "null_resource" "deployment_prep" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "echo 'Deployment started at ${timestamp()}'> deployment-${timestamp()}.log"
  }
}
