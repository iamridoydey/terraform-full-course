resource "azurerm_linux_virtual_machine" "prite_vms" {
  for_each              = var.vm_list
  name                  = each.value
  resource_group_name   = azurerm_resource_group.prite_rg.name
  location              = azurerm_resource_group.prite_rg.location
  size                  = "Standard_B2ats_V2"
  admin_username        = var.vm_username
  network_interface_ids = [azurerm_network_interface.prite_nis[each.key].id]

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

  tags = merge(var.vm_tags...)

  lifecycle {
    create_before_destroy = true
    # ignore_changes = [ tags ]
    # prevent_destroy = true
    # replace_triggered_by = [ azurerm_resource_group.prite_rg ]
    # precondition {
    #   condition = contains(var.allowed_locations, azurerm_resource_group.prite_rg.location)
    #   error_message = "Location doesn't use any allowed location"
    # }
  }
}




