data "azurerm_virtual_network" "shared-network-vnet" {
  name                = "shared-network-vnet"
  resource_group_name = "shared-network-rg"
}

data "azurerm_subnet" "shared-network-subnet" {
  name                 = "shared-network-subnet"
  virtual_network_name = "shared-network-vnet"
  resource_group_name  = "shared-network-rg"
}



resource "azurerm_network_interface" "prite_ni" {
  name                = "prite-ni"
  location            = data.azurerm_resource_group.shared-network-rg.location
  resource_group_name = data.azurerm_resource_group.shared-network-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.shared-network-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.prite_pip.id
  }
}


resource "azurerm_public_ip" "prite_pip" {
  name                = "prite-ip"
  resource_group_name = data.azurerm_resource_group.shared-network-rg.name
  location            = data.azurerm_resource_group.shared-network-rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}
