variable "vnet_name" {
  description = "name for virtual network"
  type = string
}

variable "vnet_adr_space" {
  description = "adress space for virtual network"
  type = list(string)
  validation {
    condition = length(var.vnet_adr_space)>0
    error_message = "The address space must contain atleast one entry"
  }
}



variable "subnets" {
  description = "list of subnets to create"
  type = map(object({
    name = string
    address_space = list(string)
  }))
}