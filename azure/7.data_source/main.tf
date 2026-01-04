resource "azurerm_linux_virtual_machine" "prite_vm" {
  name                  = "prite-vm"
  resource_group_name   = data.azurerm_resource_group.shared-network-rg.name
  location              = data.azurerm_resource_group.shared-network-rg.location
  size                  = "Standard_B2ats_V2"
  admin_username        = "ubuntu"
  network_interface_ids = [azurerm_network_interface.prite_ni.id]

  admin_ssh_key {
    username   = var.vm_username
    public_key = file("~/.ssh/pritedey-azure-login.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.disk_size
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

}




