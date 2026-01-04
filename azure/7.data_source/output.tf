output "network_rg_id" {
  value = data.azurerm_resource_group.shared-network-rg.id
}

output "virtual_network_id" {
  value = data.azurerm_virtual_network.shared-network-vnet.id
}

output "subnet_id" {
  value = data.azurerm_subnet.shared-network-subnet.id
}

output "prite_vm_ip" {
  value = azurerm_linux_virtual_machine.prite_vm.public_ip_address
}
