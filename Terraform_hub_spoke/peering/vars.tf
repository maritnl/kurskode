variable "peerings" {
  description = "list of peerings to create"
  type = map(object({
    name = string
    vnet_name = string
    rg_name = string
    vnet_id = string
  }))
}