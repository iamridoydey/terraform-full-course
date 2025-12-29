output "formated_project_name" {
  value = local.formated_project_name
}

output "all_ports" {
  value = local.sg_rules
}


output "instance_type" {
  value = local.instance_type
}

output "all_ami" {
  value = var.all_ami
}