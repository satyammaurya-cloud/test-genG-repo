# <--------- Data block to read Subnet ids ------------>

data "azurerm_subnet" "snets" {
  for_each = var.nics
  name                 = each.value.dsnet
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}


# <--------- Data block to read Public IP id ------------>

data "azurerm_public_ip" "pips" {
  for_each = var.nics

  name                = each.value.dpip
  resource_group_name = each.value.resource_group_name
}

# <--------- Variable for NIC ------------>

variable "nics" {
  
}

# <---------- Network Interface ------------>

resource "azurerm_network_interface" "nics" {
  for_each = var.nics

  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.snets[each.key].id
    public_ip_address_id          = data.azurerm_public_ip.pips[each.key].id
    private_ip_address_allocation = "Dynamic"

  }
}
