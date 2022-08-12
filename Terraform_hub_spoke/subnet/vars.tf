variable "subnets" {
  description = "inputs for subnet creation"
  type = map(object({
    name = string
    rg_name = string
    vnet_name = string
    address_prefixes = list(string)
  }))
}