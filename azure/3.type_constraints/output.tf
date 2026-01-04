output "virtual_machine_ip_address" {
  value = azurerm_linux_virtual_machine.prite_vm.public_ip_address
}
