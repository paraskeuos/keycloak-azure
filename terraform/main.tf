terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.53.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~>4.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  #skip_provider_registration = true
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}
