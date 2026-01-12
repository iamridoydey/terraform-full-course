data "azuread_domains" "aad_domains" {
  only_default = false
}

data "azuread_client_config" "current" {}
# Assign Owner role at subscription scope
data "azurerm_subscription" "current" {}

data "azuread_application_published_app_ids" "well_known" {}


locals {
  domain_name = data.azuread_domains.aad_domains.domains[0].domain_name
}



