resource "azurerm_resource_group" "prite_rg" {
  name     = "prite-rgs"
  location = var.allowed_locations[0]
}
