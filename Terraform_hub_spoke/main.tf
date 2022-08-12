module "rg_module" {
  source = ".//resource_group"
  resource_groups = {
    "rg_hub" = {
      name     = local.rg_name1
      location = local.location
    }
    "rg_spoke1" = {
      name     = local.rg_name2
      location = local.location
    }
    "rg_spoke2" = {
      name     = local.rg_name3
      location = local.location
    }
  }
}

module "network_module" {
  source = ".//network"
  networks = {
    "vnet_hub" = {
      name          = local.vnet_name_hub
      location      = local.location
      rg_name       = local.rg_name1
      address_space = ["10.0.0.0/16"]
    }
    "vnet_spoke1" = {
      name          = local.vnet_name_spoke1
      location      = local.location
      rg_name       = local.rg_name2
      address_space = ["10.1.0.0/16"]
    }
    "vnet_spoke2" = {
      name          = local.vnet_name_spoke2
      location      = local.location
      rg_name       = local.rg_name3
      address_space = ["10.2.0.0/16"]
    }
  }
  depends_on = [
    module.rg_module
  ]
}

module "peering_module" {
  source = ".//peering"
  peerings = {
    "spoke1tohub" = {
      name = "spoke1tohub"
      vnet_name = local.vnet_name_spoke1
      rg_name = local.rg_name2
      vnet_id = module.network_module.vnet_ids[0]
    }
    "hubtospoke1" = {
      name = "hubtospoke1"
      vnet_name = local.vnet_name_hub
      rg_name = local.rg_name1
      vnet_id = module.network_module.vnet_ids[1]
    }
    "spoke2tohub" = {
      name = "spoke2tohub"
      vnet_name = local.vnet_name_spoke2
      rg_name = local.rg_name3
      vnet_id = module.network_module.vnet_ids[0]
    }
    "hubtospoke2" = {
      name = "hubtospoke2"
      vnet_name = local.vnet_name_hub
      rg_name = local.rg_name1
      vnet_id = module.network_module.vnet_ids[2]
    }
  }
  depends_on = [
    module.network_module
  ]

}

module "subnet_module" {
  source = ".//subnet"
  subnets = {
    "spoke1_subnet" = {
      name = local.subnet_name_spoke1
      rg_name= local.rg_name2
      vnet_name = local.vnet_name_spoke1
      address_prefixes = ["10.1.1.0/24"]
    }
     "spoke2_subnet" = {
      name = local.subnet_name_spoke2
      rg_name = local.rg_name3
      vnet_name = local.vnet_name_spoke2
      address_prefixes = ["10.2.1.0/24"]
    }
  }
  depends_on = [
    module.network_module
  ]
}

module "nic_module" {
  source = ".//nic"
  nics = {
    "spoke1_nic" = {
      name = "spoke1_nic"
      location = local.location
      rg_name = local.rg_name2
      ip_config_name = "ipconfig1"
      ip_allocation = local.ip_allocation
      subnet_id = module.subnet_module.subnet_ids[0]
    }
    "spoke2_nic" = {
      name = "spoke2_nic"
      location = local.location
      rg_name = local.rg_name3
      ip_config_name = "ipconfig2"
      ip_allocation = local.ip_allocation
      subnet_id = module.subnet_module.subnet_ids[1]
    }
  }
  depends_on = [
   module.subnet_module
  ]
}
