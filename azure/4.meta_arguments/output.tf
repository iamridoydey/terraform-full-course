output "virtual_machine_ip_address" {
  value = [for vm in azurerm_linux_virtual_machine.prite_vms: vm.public_ip_address]
}
