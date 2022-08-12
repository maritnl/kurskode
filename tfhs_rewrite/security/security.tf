resource "azurerm_network_security_group" "security" {
  name = "securityname"
  location = var.rg_hub.location
  resource_group_name = var.rg_hub.name

}

resource "azurerm_network_security_rule" "rule1" {
  name = "rule1"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_hub.name
  network_security_group_name = azurerm_network_security_group.security.name
}