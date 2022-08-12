resource "azurerm_resource_group" "rg_spoke1" {
  name     = "rg_spoke1"
  location = var.location
}

resource "azurerm_resource_group" "rg_spoke2" {
  name     = "rg_spoke2"
  location = var.location
}

# Virtual networks
resource "azurerm_virtual_network" "vnet_spoke1" {
  name                = "vnet_spoke1"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_spoke1.name
  address_space       = ["10.1.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

resource "azurerm_virtual_network" "vnet_spoke2" {
  name                = "vnet_spoke2"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_spoke2.name
  address_space       = ["10.2.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

# Subnets
resource "azurerm_subnet" "subnet_spoke1" {
  name                 = "subnet_spoke1"
  resource_group_name  = azurerm_resource_group.rg_spoke1.name
  virtual_network_name = azurerm_virtual_network.vnet_spoke1.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_subnet" "subnet_spoke2" {
  name                 = "subnet_spoke2"
  resource_group_name  = azurerm_resource_group.rg_spoke2.name
  virtual_network_name = azurerm_virtual_network.vnet_spoke2.name
  address_prefixes     = ["10.2.1.0/24"]
}


# Network interfaces
resource "azurerm_network_interface" "nic_vnet_spoke1" {
  name                = "nic_vnet_spoke1"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_spoke1.name

  ip_configuration {
    name                          = "ipconfig_spoke1"
    private_ip_address_allocation = "Dynamic"
    subnet_id = azurerm_subnet.subnet_spoke1.id
  }
}

resource "azurerm_network_interface" "nic_vnet_spoke2" {
  name                = "nic_vnet_spoke2"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_spoke2.name

  ip_configuration {
    name                          = "ipconfig_spoke2"
    private_ip_address_allocation = "Dynamic"
    subnet_id = azurerm_subnet.subnet_spoke2.id
  }
}

# Virtual machines
resource "azurerm_windows_virtual_machine" "vm_spoke1" {
  name = "vm-spoke1"
  resource_group_name = azurerm_resource_group.rg_spoke1.name
  location = var.location
  size = "Standard_A1_v2"
  admin_username = "VM1_admin"
  admin_password = "VM1_admin"
  network_interface_ids = [ azurerm_network_interface.nic_vnet_spoke1.id ]
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_windows_virtual_machine" "vm_spoke2" {
  name = "vm-spoke2"
  resource_group_name = azurerm_resource_group.rg_spoke2.name
  location = var.location
  size = "Standard_A1_v2"
  admin_username = "VM2_admin"
  admin_password = "VM2_admin"
  network_interface_ids = [ azurerm_network_interface.nic_vnet_spoke2.id ]
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
