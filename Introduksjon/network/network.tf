resource "azurerm_virtual_network" "mitt_nettverk" {
  name                = var.vnet_name
  location            = data.azurerm_resource_group.min_forste_rg.location
  resource_group_name = data.azurerm_resource_group.min_forste_rg.name
  address_space       = var.vnet_adr_space
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

resource "azurerm_subnet" "mitt_subnet" {
  for_each = var.subnets
  name = each.value.name
  resource_group_name = data.azurerm_resource_group.min_forste_rg.name
  virtual_network_name = azurerm_virtual_network.mitt_nettverk.name
  address_prefixes = each.value.address_space
}