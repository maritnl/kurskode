resource "azurerm_resource_group" "min_forste_rg" {
  name     = var.min_forste_rg
  location = var.location
  tags = {
    tagnavn1      = "tagverdi1"
    tagslettstate = "slettestatewoho"
  }
}

