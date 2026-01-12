output "my_domain" {
  value = local.domain_name
}

output "user_names" {
  value = [for user in local.users : "${user.first_name}_${user.last_name}"]
}


output "azure_users" {
    value = [for user in azuread_user.azure_users : "${user.display_name}"]

}

output "azure_groups" {
  value = azuread_group.education_engineer
}

