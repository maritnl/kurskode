resource "azurerm_virtual_network" "networks" {
  for_each = var.networks
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.rg_name
  address_space       = each.value.address_space
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

output "vnet_ids" {
  value = values(azurerm_virtual_network.networks)[*].id
}