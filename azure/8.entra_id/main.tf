data "azuread_domains" "aad_domains" {
  only_default = false
}

data "azuread_client_config" "current" {}

locals {
  domain_name = data.azuread_domains.aad_domains.domains[0].domain_name
  users       = csvdecode(file("users.csv"))
}

resource "azuread_user" "azure_users" {
  for_each            = { for user in local.users : user.first_name => user }
  user_principal_name = format("%s@%s", lower(each.value.first_name), local.domain_name)
  display_name        = "${each.value.first_name} ${each.value.last_name}"
  mail_nickname       = "${lower(substr(each.value.first_name, 0, 1))}${lower(each.value.last_name)}"
  password            = "SecretP@sswd99!"
  age_group           = "Adult"
  company_name        = "Dream IT"
  department          = each.value.department
  job_title           = each.value.job_title
  force_password_change = true
}



