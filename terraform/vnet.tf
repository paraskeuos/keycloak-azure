resource "azurerm_virtual_network" "vnet" {
  name                = "${var.stack_name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.stack_name}-subnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}
