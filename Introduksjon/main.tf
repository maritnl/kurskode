provider "azurerm" {
  subscription_id = "7bd1d884-13f6-47b5-92aa-0bb6db139253"
  features {

  }
}

module "rg_module" {
  source=".//resource_group"
}

module "network_module" {
  source=".//network"
  vnet_name = "mitt_nettverk"
  vnet_adr_space = ["10.0.0.0/16"]
  subnets = {
    "subnet1" = {
      name = "subnet1"
      address_space = ["10.0.1.0/24"]
    }
    "subnet2" = {
      name = "subnet2"
      address_space = ["10.0.2.0/24"]
    }
  }
  depends_on = [
    module.rg_module
  ]
}