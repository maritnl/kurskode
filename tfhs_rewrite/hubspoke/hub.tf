resource "azurerm_resource_group" "rg_hub" {
  name     = "rg_hub"
  location = var.location
}

output "rg_hub_out" {
  value = azurerm_resource_group.rg_hub
}

resource "azurerm_virtual_network" "vnet_hub" {
  name                = "vnet_spoke1"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_hub.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

resource "azurerm_virtual_network_peering" "spoke1tohub" {
  name                      = "spoke1tohub"
  resource_group_name       = azurerm_resource_group.rg_spoke1.name
  virtual_network_name      = azurerm_virtual_network.vnet_spoke1.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_hub.id
}

resource "azurerm_virtual_network_peering" "spoke2tohub" {
  name                      = "spoke2tohub"
  resource_group_name       = azurerm_resource_group.rg_spoke2.name
  virtual_network_name      = azurerm_virtual_network.vnet_spoke2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_hub.id
}

resource "azurerm_virtual_network_peering" "hubtospoke1" {
  name                      = "hubtospoke1"
  resource_group_name       = azurerm_resource_group.rg_hub.name
  virtual_network_name      = azurerm_virtual_network.vnet_hub.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_spoke1.id
}

resource "azurerm_virtual_network_peering" "hubtospoke2" {
  name                      = "hubtospoke2"
  resource_group_name       = azurerm_resource_group.rg_hub.name
  virtual_network_name      = azurerm_virtual_network.vnet_hub.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_spoke2.id
}
