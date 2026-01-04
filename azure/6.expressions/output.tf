output "security_rule" {
  value = azurerm_network_security_group.prite_nsg.security_rule[*].name
}