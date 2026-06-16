locals {
  public_ip_name    = "${var.vm_name}-pip"
  nsg_name          = "${var.vm_name}-nsg"
  nic_name          = "${var.vm_name}-nic"
  rdp_source_prefix = var.allowed_rdp_cidr != null ? var.allowed_rdp_cidr : "*"
  computer_name     = substr(replace(var.vm_name, "-", ""), 0, 15)
}

resource "azurerm_public_ip" "jumpbox_public_ip" {
  name                = local.public_ip_name
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_network_security_group" "jumpbox_nsg" {
  name                = local.nsg_name
  location            = var.location
  resource_group_name = var.rg_name
  tags                = var.tags

  security_rule {
    name                       = "AllowRDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = local.rdp_source_prefix
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "jumpbox_nic" {
  name                = local.nic_name
  location            = var.location
  resource_group_name = var.rg_name
  tags                = var.tags

  ip_configuration {
    name                          = "primary"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jumpbox_public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "jumpbox_nic_nsg_association" {
  network_interface_id      = azurerm_network_interface.jumpbox_nic.id
  network_security_group_id = azurerm_network_security_group.jumpbox_nsg.id
}

resource "azurerm_windows_virtual_machine" "jumpbox_vm" {
  name                = var.vm_name
  computer_name       = local.computer_name
  location            = var.location
  resource_group_name = var.rg_name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.jumpbox_nic.id,
  ]
  tags = var.tags

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
}
