resource "azurerm_virtual_network" "prite_vnet" {
  name                = "prite_vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.prite_rg.location
  resource_group_name = azurerm_resource_group.prite_rg.name
}

resource "azurerm_subnet" "prite_subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.prite_rg.name
  virtual_network_name = azurerm_virtual_network.prite_rg.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "prite_nic" {
  name                = "prite_nic"
  location            = azurerm_resource_group.prite_rg.location
  resource_group_name = azurerm_resource_group.prite_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}