resource "azurerm_resource_group" "prite_rg" {
  name     = "prite-resources"
  location = var.allowed_locations[0]
}
