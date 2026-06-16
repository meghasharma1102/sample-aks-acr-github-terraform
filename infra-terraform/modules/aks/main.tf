locals {
  pod_cidr               = "10.244.0.0/16"
  service_cidr           = "10.100.0.0/16"
  dns_service_ip         = "10.100.0.10"
  user_node_pool_enabled = var.user_node_pool_name != null && var.user_node_pool_vm_size != null && var.user_node_pool_min_count != null && var.user_node_pool_max_count != null
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                    = var.cluster_name
  location                = var.location
  resource_group_name     = var.rg_name
  dns_prefix              = var.dns_prefix
  kubernetes_version      = var.kubernetes_version
  private_cluster_enabled = true
  private_dns_zone_id     = "System"
  node_resource_group     = var.node_resource_group_name

  azure_policy_enabled              = true
  role_based_access_control_enabled = true
  local_account_disabled            = false
  oidc_issuer_enabled               = true
  workload_identity_enabled         = true
  sku_tier                          = "Standard"

  default_node_pool {
    name                 = "system"
    vm_size              = var.system_node_pool_vm_size
    vnet_subnet_id       = var.aks_subnet_id
    auto_scaling_enabled = true
    min_count            = var.system_node_pool_min_count
    max_count            = var.system_node_pool_max_count
    max_pods             = 30
    os_disk_type         = "Managed"
    os_disk_size_gb      = 128
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "azure"
    service_cidr        = local.service_cidr
    dns_service_ip      = local.dns_service_ip
    pod_cidr            = local.pod_cidr
    outbound_type       = "loadBalancer"
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "cluster_subnet_network_contributor" {
  scope                = var.aks_subnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.cluster.identity[0].principal_id
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
}

resource "azurerm_kubernetes_cluster_node_pool" "user" {
  count                 = local.user_node_pool_enabled ? 1 : 0
  name                  = var.user_node_pool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.cluster.id
  vm_size               = var.user_node_pool_vm_size
  mode                  = "User"
  vnet_subnet_id        = var.aks_subnet_id
  auto_scaling_enabled  = true
  min_count             = var.user_node_pool_min_count
  max_count             = var.user_node_pool_max_count
  max_pods              = 30
  os_disk_type          = "Managed"
  os_disk_size_gb       = 128
  tags                  = var.tags
}
