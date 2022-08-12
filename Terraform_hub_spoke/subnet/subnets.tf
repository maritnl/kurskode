resource "azurerm_subnet" "subnets" {
  for_each = var.subnets
  name                 = each.value.name
  resource_group_name  = each.value.rg_name
  virtual_network_name = each.value.vnet_name
  address_prefixes     = each.value.address_prefixes
}

output "subnet_ids" {
  value = values(azurerm_subnet.subnets)[*].id
}