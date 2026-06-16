terraform {
  backend "azurerm" {

    resource_group_name  = "rg-backup-state-01"
    storage_account_name = "stcaseprojecttfstate"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
    use_azuread_auth     = true
  }
}
