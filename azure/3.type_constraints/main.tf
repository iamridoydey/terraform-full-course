resource "azurerm_linux_virtual_machine" "prite_vm" {
  name                = "prite_vm"
  resource_group_name = azurerm_resource_group.prite_rg.name
  location            = azurerm_resource_group.prite_rg.location
  size                = "B2_ats_V2"
  admin_username      = "ubuntu"
  network_interface_ids = [
    azurerm_network_interface.prite_nic.id,
  ]

  admin_ssh_key {
    username   = "ubuntu"
    public_key = file("~/.ssh/pritedey-azure-login.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb = 30
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}