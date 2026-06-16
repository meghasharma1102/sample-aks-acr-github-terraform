resource "azurerm_container_registry" "registry" {
  name                          = var.acr_name
  location                      = var.location
  resource_group_name           = var.rg_name
  sku                           = "Premium"
  admin_enabled                 = false
  public_network_access_enabled = false
  tags                          = var.tags
}

resource "azurerm_private_dns_zone" "registry_dns_zone" {
  name                = var.private_dns_zone_name
  resource_group_name = var.rg_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "registry_dns_link" {
  name                  = "${var.acr_name}-dns-link"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.registry_dns_zone.name
  virtual_network_id    = var.vnet_id
  registration_enabled  = false
}

resource "azurerm_private_endpoint" "registry_private_endpoint" {
  name                = var.private_endpoint_name
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "${var.acr_name}-private-connection"
    private_connection_resource_id = azurerm_container_registry.registry.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }

  private_dns_zone_group {
    name                 = "${var.acr_name}-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.registry_dns_zone.id]
  }
}
