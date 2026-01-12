terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.7.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.57.0"
    }
  }
}

# Entra ID / Graph provider
provider "azuread" {
  # tenant_id can be set explicitly if needed
  # tenant_id = "<your-tenant-id>"
}

# Azure Resource Manager provider
provider "azurerm" {
  features {}
}
