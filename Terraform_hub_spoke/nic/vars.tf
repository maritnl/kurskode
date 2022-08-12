variable "nics" {
  description = "input for nic creation"
  type = map(object({
    name = string
    location = string
    rg_name = string
    ip_config_name = string  
    ip_allocation = string
    subnet_id = string
  }))
}