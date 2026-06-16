output "cluster_name" {
  value = azurerm_kubernetes_cluster.cluster.name
}

output "private_fqdn" {
  value = azurerm_kubernetes_cluster.cluster.private_fqdn
}
