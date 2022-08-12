variable "rg_hub" {
  description = "resource group to monitor"
  type = object({
    name = string
    location = string
  })
}