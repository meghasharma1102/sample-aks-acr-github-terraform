output "acr_id" {
  value = azurerm_container_registry.registry.id
}

output "acr_name" {
  value = azurerm_container_registry.registry.name
}

output "login_server" {
  value = azurerm_container_registry.registry.login_server
}
