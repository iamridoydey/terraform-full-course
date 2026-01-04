
resource "azurerm_network_security_group" "prite_nsg" {
  name                = var.tags.environment == "dev" ? "prite-nsgdev" : "prite-nsgstag"
  location            = azurerm_resource_group.prite_rg.location
  resource_group_name = azurerm_resource_group.prite_rg.name

  dynamic "security_rule" {
    for_each = var.security_rules

    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

  tags = {
    environment = var.tags.environment
  }
}




