variable "resource_groups" {
  description = "list of resource groups to create"
  type = map(object({
    name = string
    location = string
  }))
}