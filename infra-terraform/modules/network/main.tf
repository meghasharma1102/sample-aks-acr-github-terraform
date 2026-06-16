resource "azurerm_virtual_network" "virtual_network" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.vnet_cidrs
  tags                = var.tags
}

resource "azurerm_subnet" "aks" {
  name                 = var.aks_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = var.aks_subnet_cidrs
}

resource "azurerm_subnet" "vm" {
  name                 = var.vm_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = var.vm_subnet_cidrs
}

resource "azurerm_subnet" "private_endpoints" {
  name                 = var.private_endpoint_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = var.private_endpoint_subnet_cidrs

  private_endpoint_network_policies = "Disabled"
}
