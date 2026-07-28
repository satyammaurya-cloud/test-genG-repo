variable "nsgs" {

}

variable "nics" {

}

variable "nsg_attachments" {

}


# <--------- Data block to read NIC id ------------>

data "azurerm_network_interface" "nics" {
  for_each = var.nics

  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name
}


# <--------- Data block to read NSG id ------------>

data "azurerm_network_security_group" "nsgs" {
  for_each = var.nsgs

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# <---------- NSG attachment with the NIC card ------------>

resource "azurerm_network_interface_security_group_association" "nsg_attachments" {

  for_each = var.nsg_attachments

  network_interface_id      = data.azurerm_network_interface.nics[each.value.nic_key].id
  network_security_group_id = data.azurerm_network_security_group.nsgs[each.value.nsg_key].id
}