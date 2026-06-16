output "resource_group_name" {
  value = data.azurerm_resource_group.resource_group.name
}

output "aks_cluster_name" {
  value = module.aks.cluster_name
}

output "aks_private_fqdn" {
  value = module.aks.private_fqdn
}

output "acr_name" {
  value = module.acr.acr_name
}

output "acr_login_server" {
  value = module.acr.login_server
}

output "jumpbox_vm_name" {
  value = module.jumpbox_vm.vm_name
}

output "jumpbox_public_ip" {
  value = module.jumpbox_vm.public_ip_address
}

output "jumpbox_private_ip" {
  value = module.jumpbox_vm.private_ip_address
}
