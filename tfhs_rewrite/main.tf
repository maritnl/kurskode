module "hub_and_spoke" {
  source = ".//hubspoke"
  depends_on = [
    module.policy
  ]
}

module "monitoring" {
  source = ".//monitoring"
  rg_hub = {
    name     = module.hub_and_spoke.rg_hub_out.name
    location = module.hub_and_spoke.rg_hub_out.location
    id       = module.hub_and_spoke.rg_hub_out.id
  }
}

module "security" {
  source = ".//security"
  rg_hub = {
    name     = module.hub_and_spoke.rg_hub_out.name
    location = module.hub_and_spoke.rg_hub_out.location
  }
}

module "policy" {
  source    = ".//policy"
  locations = ["west europe"]
}

# module "rbac" {
#   source    = ".//azuread"
#   depends_on = [
#     module.hub_and_spoke
#   ]
# }
