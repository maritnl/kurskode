resource "azurerm_virtual_machine" "vms" {
  for_each = var.vms
  name                  = "${each.value.name}_vm"
  location              = each.value.location
  resource_group_name   = each.value.rg_name
  network_interface_ids = each.value.nic_ids
  vm_size               = "Standard_A1_v2"
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  os_profile {
    computer_name = each.value.computer_name
    admin_password = each.value.admin_password
    admin_username = each.value.admin_username
  }

  os_profile_windows_config {
    
  }

  storage_os_disk {
    name = each.value.disk_name
    create_option = "FromImage"
  }
}
