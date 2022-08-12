resource "azurerm_network_interface" "nics" {
  for_each = var.nics
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  ip_configuration {
    name                          = each.value.ip_config_name
    private_ip_address_allocation = each.value.ip_allocation
    subnet_id = each.value.subnet_id
  }
}

output "nic_ids" {
  value = values(azurerm_network_interface.nics)[*].id
}