output "vm_name" {
  value = azurerm_windows_virtual_machine.jumpbox_vm.name
}

output "public_ip_address" {
  value = azurerm_public_ip.jumpbox_public_ip.ip_address
}

output "private_ip_address" {
  value = azurerm_network_interface.jumpbox_nic.private_ip_address
}
