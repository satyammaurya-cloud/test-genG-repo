rg = {
  rg1 = {
    name     = "satyam-rg"
    location = "centralindia"
  }
}

vnet = {
  vnet1 = {
    name                = "tcs-vnet"
    location            = "centralindia"
    resource_group_name = "satyam-rg"
    address_space       = ["10.0.0.0/16"]
  }
}

snet = {
  snet1 = {
    name                 = "frontend-subnet"
    resource_group_name  = "satyam-rg"
    virtual_network_name = "tcs-vnet"
    address_prefixes     = ["10.0.1.0/24"]
  }
  snet2 = {
    name                 = "backend-subnet"
    resource_group_name  = "satyam-rg"
    virtual_network_name = "tcs-vnet"
    address_prefixes     = ["10.0.2.0/24"]
  }
}

pip = {
  pip1 = {
    name                = "frontend-vm-pip"
    resource_group_name = "satyam-rg"
    location            = "centralindia"
    allocation_method   = "Static"
  }
  pip2 = {
    name                = "backend-vm-pip"
    resource_group_name = "satyam-rg"
    location            = "centralindia"
    allocation_method   = "Static"
  }
}

nic = {
  nic1 = {
    nic_name             = "frontend-vm-nic"
    location             = "centralindia"
    resource_group_name  = "satyam-rg"
    virtual_network_name = "tcs-vnet"
    dsnet                = "frontend-subnet"
    dpip                 = "frontend-vm-pip"

  }
  nic2 = {
    nic_name             = "backend-vm-nic"
    location             = "centralindia"
    resource_group_name  = "satyam-rg"
    virtual_network_name = "tcs-vnet"
    dsnet                = "backend-subnet"
    dpip                 = "backend-vm-pip"
  }
}


vm = {
  vm1 = {
    name                = "frontend-vm-1"
    nic_name            = "frontend-vm-nic"
    location            = "centralindia"
    resource_group_name = "satyam-rg"
    vm_size             = "Standard_D2s_v3"
    admin_username      = "front-server-01"
    admin_password      = "Password1234!"
  }
  vm2 = {
    name                = "backedn-vm-2"
    nic_name            = "backend-vm-nic"
    location            = "centralindia"
    resource_group_name = "satyam-rg"
    vm_size             = "Standard_D2s_v3"
    admin_username      = "back-server-02"
    admin_password      = "Password4321!"
  }
}


nsg = {
  nsg1 = {
    name                   = "frontend-vm-nsg"
    location               = "centralindia"
    resource_group_name    = "satyam-rg"
    rule_name              = "ssh-rule"
    priority               = "100"
    destination_port_range = "22"
    source_address_prefix  = "0.0.0.0/0"
  }

  nsg2 = {
    name                   = "backend-vm-nsg"
    location               = "centralindia"
    resource_group_name    = "satyam-rg"
    rule_name              = "ssh-rule"
    priority               = "100"
    destination_port_range = "22"
    source_address_prefix  = "0.0.0.0/0"
  }
}

nsg_attachment = {
  attach1 = {
    nic_key = "nic1"
    nsg_key = "nsg1"
  }

  attach2 = {
    nic_key = "nic2"
    nsg_key = "nsg2"
  }
}