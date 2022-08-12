variable "vms" {
  description = "input for creation of virtual machines"
  type = map(object({
    name = string
    location = string
    rg_name = string
    nic_ids = list(string)
    computer_name = string
    admin_username = string
    admin_password = string
    disk_name = string
  }))
}
