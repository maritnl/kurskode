resource "azurerm_virtual_network_peering" "peerings" {
  for_each = var.peerings
  name                      = each.value.name
  resource_group_name       = each.value.rg_name
  virtual_network_name      = each.value.vnet_name
  remote_virtual_network_id = each.value.vnet_id
}