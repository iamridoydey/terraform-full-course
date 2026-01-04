resource "azurerm_resource_group" "prite_rg" {
  name     = "prite-resources"
  location = "East Asia"
}

resource "azurerm_storage_account" "prite_sa" {
  name                     = "iampritedeystorage"
  resource_group_name      = azurerm_resource_group.prite_rg.name
  location                 = azurerm_resource_group.prite_rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = var.environment
  }
}

