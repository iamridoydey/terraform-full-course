resource "azuread_group" "education_manager" {
  display_name     = "Education Manager"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
  members = [
    for user in azuread_user.azure_users : 
    user.object_id 
    if lower(user.job_title) == "manager"
  ]
}

resource "azuread_group" "education_engineer" {
  display_name     = "Education Engineer"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
  members = [
    for user in azuread_user.azure_users : 
    user.object_id 
    if lower(user.job_title) == "engineer"
  ]
}