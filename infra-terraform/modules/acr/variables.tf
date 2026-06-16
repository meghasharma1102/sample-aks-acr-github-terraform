variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "acr_name" {
  type = string
}

variable "private_endpoint_name" {
  type = string
}

variable "private_dns_zone_name" {
  type = string
}

variable "private_endpoint_subnet_id" {
  type = string
}

variable "vnet_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
