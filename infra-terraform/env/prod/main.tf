data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

module "network" {
  source                        = "../../modules/network"
  rg_name                       = data.azurerm_resource_group.resource_group.name
  location                      = data.azurerm_resource_group.resource_group.location
  vnet_name                     = var.vnet_name
  vnet_cidrs                    = var.vnet_cidrs
  aks_subnet_name               = var.aks_subnet_name
  aks_subnet_cidrs              = var.aks_subnet_cidrs
  vm_subnet_name                = var.vm_subnet_name
  vm_subnet_cidrs               = var.vm_subnet_cidrs
  private_endpoint_subnet_name  = var.private_endpoint_subnet_name
  private_endpoint_subnet_cidrs = var.private_endpoint_subnet_cidrs
  tags                          = var.tags
}

module "acr" {
  source                     = "../../modules/acr"
  rg_name                    = data.azurerm_resource_group.resource_group.name
  location                   = data.azurerm_resource_group.resource_group.location
  acr_name                   = var.acr_name
  private_endpoint_name      = var.acr_private_endpoint_name
  private_dns_zone_name      = var.acr_private_dns_zone_name
  private_endpoint_subnet_id = module.network.private_endpoint_subnet_id
  vnet_id                    = module.network.vnet_id
  tags                       = var.tags
}

module "aks" {
  source                     = "../../modules/aks"
  rg_name                    = data.azurerm_resource_group.resource_group.name
  location                   = data.azurerm_resource_group.resource_group.location
  cluster_name               = var.aks_cluster_name
  dns_prefix                 = var.aks_dns_prefix
  kubernetes_version         = var.kubernetes_version
  aks_subnet_id              = module.network.aks_subnet_id
  acr_id                     = module.acr.acr_id
  node_resource_group_name   = var.node_resource_group_name
  system_node_pool_vm_size   = var.system_node_pool_vm_size
  system_node_pool_min_count = var.system_node_pool_min_count
  system_node_pool_max_count = var.system_node_pool_max_count
  user_node_pool_name        = var.user_node_pool_name
  user_node_pool_vm_size     = var.user_node_pool_vm_size
  user_node_pool_min_count   = var.user_node_pool_min_count
  user_node_pool_max_count   = var.user_node_pool_max_count
  tags                       = var.tags
}

module "jumpbox_vm" {
  source           = "../../modules/jumpbox_vm"
  rg_name          = data.azurerm_resource_group.resource_group.name
  location         = data.azurerm_resource_group.resource_group.location
  subnet_id        = module.network.vm_subnet_id
  vm_name          = var.jumpbox_vm_name
  vm_size          = var.jumpbox_vm_size
  admin_username   = var.admin_username
  admin_password   = var.admin_password
  allowed_rdp_cidr = var.allowed_rdp_cidr
  tags             = var.tags
}
