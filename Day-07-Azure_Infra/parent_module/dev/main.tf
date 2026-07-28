module "resource_group" {
  source = "../../child_module/azurerm_resource_group"

  rgs = var.rg

}

module "virtual_network" {
  depends_on = [module.resource_group]

  source = "../../child_module/azurerm_virtual_network"

  vnets = var.vnet
}

module "subnet" {
  depends_on = [module.virtual_network]

  source = "../../child_module/azurerm_subnet"
  snets  = var.snet
}

module "public_ip" {
  depends_on = [module.subnet]

  source = "../../child_module/azurerm_pip"
  pips   = var.pip

}

module "network_interface" {
  depends_on = [module.public_ip, module.subnet]

  source = "../../child_module/azurerm_nic"
  nics   = var.nic

}

module "virtual_machine" {
  depends_on = [module.network_interface_security_group_association]

  source = "../../child_module/azurerm_virtual_machine"
  vms    = var.vm
}

module "network_security_group" {
  depends_on = [module.resource_group]

  source = "../../child_module/azurerm_nsg"
  nsgs   = var.nsg

}

module "network_interface_security_group_association" {
  depends_on = [module.network_interface, module.network_security_group]
  source     = "../../child_module/azurerm_nsg_attachment"

  nics            = var.nic
  nsgs            = var.nsg
  nsg_attachments = var.nsg_attachment
}