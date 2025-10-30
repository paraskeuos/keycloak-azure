terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-rg"
    storage_account_name = "tfstatesctrial"
    container_name       = "tfstate"
    key                  = ".tfstate"
    use_azuread_auth     = true
    use_oidc             = true
  }
}
