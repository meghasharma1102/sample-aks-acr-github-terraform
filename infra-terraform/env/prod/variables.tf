variable "subscription_id" {
  description = "Azure subscription id used by the provider."
  type        = string
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
}

variable "resource_group_name" {
  description = "Main resource group name."
  type        = string
}

variable "node_resource_group_name" {
  description = "AKS managed node resource group name."
  type        = string
}

variable "vnet_name" {
  description = "Virtual network name."
  type        = string
}

variable "vnet_cidrs" {
  description = "Address space for the VNet."
  type        = list(string)
}

variable "aks_subnet_name" {
  description = "AKS subnet name."
  type        = string
}

variable "aks_subnet_cidrs" {
  description = "AKS subnet address prefixes."
  type        = list(string)
}

variable "vm_subnet_name" {
  description = "Jumpbox VM subnet name."
  type        = string
}

variable "vm_subnet_cidrs" {
  description = "Jumpbox VM subnet address prefixes."
  type        = list(string)
}

variable "private_endpoint_subnet_name" {
  description = "Private endpoint subnet name."
  type        = string
}

variable "private_endpoint_subnet_cidrs" {
  description = "Private endpoint subnet address prefixes."
  type        = list(string)
}

variable "acr_name" {
  description = "Azure Container Registry name."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{5,50}$", var.acr_name))
    error_message = "acr_name must be 5 to 50 lowercase alphanumeric characters."
  }
}

variable "acr_private_endpoint_name" {
  description = "Private endpoint name for ACR."
  type        = string
}

variable "acr_private_dns_zone_name" {
  description = "Private DNS zone used by ACR."
  type        = string
  default     = "privatelink.azurecr.io"
}

variable "aks_cluster_name" {
  description = "AKS cluster name."
  type        = string
}

variable "aks_dns_prefix" {
  description = "AKS dns prefix."
  type        = string
}

variable "kubernetes_version" {
  description = "Supported AKS Kubernetes version for the selected region."
  type        = string
}

variable "system_node_pool_vm_size" {
  description = "VM size for the AKS system node pool."
  type        = string
}

variable "system_node_pool_min_count" {
  description = "Minimum node count for the AKS system node pool."
  type        = number
}

variable "system_node_pool_max_count" {
  description = "Maximum node count for the AKS system node pool."
  type        = number
}

variable "user_node_pool_name" {
  description = "AKS user node pool name."
  type        = string
  default     = null
  nullable    = true
}

variable "user_node_pool_vm_size" {
  description = "VM size for the AKS user node pool."
  type        = string
  default     = null
  nullable    = true
}

variable "user_node_pool_min_count" {
  description = "Minimum node count for the AKS user node pool."
  type        = number
  default     = null
  nullable    = true
}

variable "user_node_pool_max_count" {
  description = "Maximum node count for the AKS user node pool."
  type        = number
  default     = null
  nullable    = true
}

variable "jumpbox_vm_name" {
  description = "Jumpbox VM name."
  type        = string
}

variable "jumpbox_vm_size" {
  description = "Jumpbox VM size."
  type        = string
}

variable "admin_username" {
  description = "Admin username for the Windows jumpbox VM."
  type        = string
}

variable "admin_password" {
  description = "Admin password for the Windows jumpbox VM."
  type        = string
  sensitive   = true
}

variable "allowed_rdp_cidr" {
  description = "Optional source CIDR allowed to RDP into the VM. Leave null for demo simplicity to allow RDP from anywhere."
  type        = string
  default     = null
  nullable    = true
}

variable "tags" {
  description = "Common tags."
  type        = map(string)
  default     = {}
}
