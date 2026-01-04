terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.57.0"
    }
  }

  backend "azurerm" {
    resource_group_name = "tfstate-demo"
    storage_account_name = "tfstate26150"                             
    container_name       = "tfstate"                              
    key                  = "dev.terraform.tfstate"           
  }

}

provider "azurerm" {
  features {

  }
}



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
    environment = "dev"
  }
}

output "storage_account_id" {
  value = azurerm_storage_account.prite_sa.id
}
