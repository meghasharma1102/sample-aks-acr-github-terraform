output "vnet_id" {
  value = azurerm_virtual_network.virtual_network.id
}

output "aks_subnet_id" {
  value = azurerm_subnet.aks.id
}

output "vm_subnet_id" {
  value = azurerm_subnet.vm.id
}

output "private_endpoint_subnet_id" {
  value = azurerm_subnet.private_endpoints.id
}
