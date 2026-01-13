resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}


resource "azurerm_storage_account" "func_storage_account" {
  name                     = "iamridoydeyfuncstorage"
  resource_group_name      = azurerm_resource_group.func_rg.name
  location                 = azurerm_resource_group.func_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "func_sp" {
  name                = "${var.project_name}-sp"
  resource_group_name = azurerm_resource_group.func_rg.name
  location            = azurerm_resource_group.func_rg.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_function_app" "func_app" {
  name                       = "${var.project_name}-app-${random_string.suffix.result}"
  location                   = azurerm_resource_group.func_rg.location
  resource_group_name        = azurerm_resource_group.func_rg.name
  service_plan_id            = azurerm_service_plan.func_sp.id
  storage_account_name       = azurerm_storage_account.func_storage_account.name
  storage_account_access_key = azurerm_storage_account.func_storage_account.primary_access_key


  site_config {
    always_on = true
    cors { allowed_origins = ["https://portal.azure.com"] }
    application_stack {
      node_version = "22"
    }
  }
}



resource "azurerm_function_app_function" "greeting_func" {
  name            = "greeting-${var.project_name}"
  function_app_id = azurerm_linux_function_app.func_app.id
  language        = "Javascript"
  test_data = jsonencode({
    "name" = "Azure"
  })
  config_json = jsonencode({
    "bindings" = [
      {
        "authLevel" = "function"
        "direction" = "in"
        "methods" = [
          "get",
          "post",
        ]
        "name" = "req"
        "type" = "httpTrigger"
      },
      {
        "direction" = "out"
        "name"      = "$return"
        "type"      = "http"
      },
    ]
  })
}
