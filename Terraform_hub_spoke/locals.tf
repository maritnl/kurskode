locals {
  rg_name1 = "rg_hub"
  rg_name2 = "rg_spoke1"
  rg_name3 = "rg_spoke2"
  location = "west europe"

  vnet_name_hub = "vnet_hub"
  vnet_name_spoke1 = "vnet_spoke1"
  vnet_name_spoke2 = "vnet_spoke2"

  subnet_name_spoke1 = "spoke1_subnet"
  subnet_name_spoke2 = "spoke2_subnet"

  ip_allocation = "Dynamic"
}