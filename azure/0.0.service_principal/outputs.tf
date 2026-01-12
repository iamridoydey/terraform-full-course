output "my_domain" {
  value = local.domain_name
}


output "sp_client_id" {
  value = azuread_application.entraid_app.client_id
}

output "sp_tenant_id" {
  value = data.azuread_client_config.current.tenant_id
}

output "sp_secret" {
  value     = azuread_service_principal_password.sp_pass.value
  sensitive = true
}

output "subscription_id" {
  value = data.azurerm_subscription.current.id
}
