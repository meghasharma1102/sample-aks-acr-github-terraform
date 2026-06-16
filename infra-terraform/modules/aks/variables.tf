variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "aks_subnet_id" {
  type = string
}

variable "acr_id" {
  type = string
}

variable "node_resource_group_name" {
  type = string
}

variable "system_node_pool_vm_size" {
  type = string
}

variable "system_node_pool_min_count" {
  type = number
}

variable "system_node_pool_max_count" {
  type = number
}

variable "user_node_pool_name" {
  type     = string
  default  = null
  nullable = true
}

variable "user_node_pool_vm_size" {
  type     = string
  default  = null
  nullable = true
}

variable "user_node_pool_min_count" {
  type     = number
  default  = null
  nullable = true
}

variable "user_node_pool_max_count" {
  type     = number
  default  = null
  nullable = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
