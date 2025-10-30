terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-rg"
    storage_account_name = "tfstatesctrial"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_azuread_auth     = true
    use_oidc             = true
  }
}
