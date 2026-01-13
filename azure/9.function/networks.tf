# Resource group
resource "azurerm_resource_group" "func_rg" {
  name     = "${var.project_name}-rg"
  location = "Korea Central"
}


