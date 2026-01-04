resource "azurerm_virtual_network" "prite_vnet" {
  name                = "prite_vnet"
  address_space       = [element(var.ip_configuration, 0)]
  location            = azurerm_resource_group.prite_rg.location
  resource_group_name = azurerm_resource_group.prite_rg.name
}

resource "azurerm_subnet" "prite_subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.prite_rg.name
  virtual_network_name = azurerm_virtual_network.prite_vnet.name
  address_prefixes     = ["${element(var.ip_configuration, 1)}/${element(var.ip_configuration, 2)}"]
}

resource "azurerm_network_interface" "prite_nis" {
  for_each = var.vm_list
  name                = "${each.value}-nic"
  location            = azurerm_resource_group.prite_rg.location
  resource_group_name = azurerm_resource_group.prite_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.prite_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.prite_pips[each.key].id
  }
}


resource "azurerm_public_ip" "prite_pips" {
  for_each = var.vm_list
  name                = "${each.value}-ip"
  resource_group_name = azurerm_resource_group.prite_rg.name
  location            = azurerm_resource_group.prite_rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}