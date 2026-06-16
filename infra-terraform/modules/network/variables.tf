variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_cidrs" {
  type = list(string)
}

variable "aks_subnet_name" {
  type = string
}

variable "aks_subnet_cidrs" {
  type = list(string)
}

variable "vm_subnet_name" {
  type = string
}

variable "vm_subnet_cidrs" {
  type = list(string)
}

variable "private_endpoint_subnet_name" {
  type = string
}

variable "private_endpoint_subnet_cidrs" {
  type = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}
