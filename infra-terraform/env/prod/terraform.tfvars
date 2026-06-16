subscription_id          = "7b8f8a16-fc9d-49db-b186-7eff08883016"
location                 = "uaenorth"
resource_group_name      = "CIA-MEGHA-RG-01"
node_resource_group_name = "rg-aks-private-01-nodes"

vnet_name  = "vnet-aks-private-01"
vnet_cidrs = ["10.40.0.0/16"]

aks_subnet_name  = "snet-aks"
aks_subnet_cidrs = ["10.40.1.0/24"]

vm_subnet_name  = "snet-jumpbox"
vm_subnet_cidrs = ["10.40.2.0/24"]

private_endpoint_subnet_name  = "snet-private-endpoints"
private_endpoint_subnet_cidrs = ["10.40.3.0/24"]

acr_name                  = "acrprivatedemo01"
acr_private_endpoint_name = "pe-acr-private-01"
acr_private_dns_zone_name = "privatelink.azurecr.io"

aks_cluster_name   = "aks-private-01"
aks_dns_prefix     = "aks-private-01"
kubernetes_version = "1.34.7" # default version

system_node_pool_vm_size   = "Standard_D2s_v5"
system_node_pool_min_count = 1
system_node_pool_max_count = 1

# user_node_pool_name = "usernp1"
# user_node_pool_vm_size = "Standard_D4ds_v5"
# user_node_pool_min_count = 1
# user_node_pool_max_count = 5

jumpbox_vm_name = "vm-aks-jumpbox-01"
jumpbox_vm_size = "Standard_B2s"
admin_username  = "azureuser"
# Provide the password via TF_VAR_admin_password locally or the JUMPBOX_ADMIN_PASSWORD GitHub secret.
# Optional for demo. If commented, Terraform allows RDP from anywhere.
# allowed_rdp_cidr = "203.0.113.10/32"

tags = {
  environment = "prod"
  owner       = "devops"
  project     = "terraform"
}
