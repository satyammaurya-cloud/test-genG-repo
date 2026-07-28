# <---------- Data block to read NIC ids ------------>

data "azurerm_network_interface" "nics" {
  for_each = var.vms

  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name
}

# <---------- Variable for VM ------------>

variable "vms" {
  
}

# <---------- Virtual Machine ------------>

resource "azurerm_virtual_machine" "vms" {

  for_each = var.vms

  name                  = each.value.name
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  network_interface_ids = [data.azurerm_network_interface.nics[each.key].id]
  vm_size               = each.value.vm_size

# Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true
  
  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${each.value.name}-osdisk"  #frontend-vm-1-osdisk  and backend-vm-2-osdisk
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = each.value.admin_username
    admin_password = each.value.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  
}
