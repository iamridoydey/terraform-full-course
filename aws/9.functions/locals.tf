locals {
  formated_project_name = lower(replace(var.project_name, " ", "-"))
  
  splitted_ports = split(" ", var.all_ports)

  sg_rules = [
    for port in local.splitted_ports:
    {
      name = "port-${port}"
      port = port
      description = "Allow traffic on port ${port}"
    }
  ]


  instance_type = lookup(var.instance_types, var.env, "m7i-flex.large")
}