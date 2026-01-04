terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-demo"
    storage_account_name = "tfstate26150"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}
