resource "azurerm_resource_group" "prite_rg" {
  name     = "prite-rg"
  location = var.allowed_locations[0]
}
