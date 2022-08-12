variable "networks" {
  description = "list of networks to create"
  type = map(object({
    name = string
    location = string
    rg_name = string
    address_space = list(string)
  }))
}