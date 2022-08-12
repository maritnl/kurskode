module "hub_and_spoke" {
  source = ".//hubspoke"

}

module "monitoring" {
  source = ".//monitoring"
  rg_hub = {
    name = module.hub_and_spoke.rg_hub_out.name
    location = module.hub_and_spoke.rg_hub_out.location
    id = module.hub_and_spoke.rg_hub_out.id
  }
  depends_on = [
    module.hub_and_spoke
  ]
}

module "security" {
  source = ".//security"
  rg_hub = {
    name = module.hub_and_spoke.rg_hub_out.name
    location = module.hub_and_spoke.rg_hub_out.location
  }
  depends_on = [
    module.hub_and_spoke
  ]
}

module "policy" {
  source = ".//policy"
  locations = ["west europe"]
}

