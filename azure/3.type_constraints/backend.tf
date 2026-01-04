terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-demo"
    storage_account_name = "tfstate10796"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}
