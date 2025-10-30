resource "azurerm_public_ip" "public_ip" {
  name                = "${var.stack_name}-public-ip"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.stack_name}-nic"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                = "${var.stack_name}-vm"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  size                = "Standard_B2s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  #source_image_id = "/communityGalleries/fedora-5e266ba4-2250-406d-adad-5d73860d958f/images/Fedora-Cloud-42-x64/versions/latest"

  source_image_reference {
    publisher = "almalinux"
    offer = "almalinux-x86_64"
    sku = "9-gen2"
    version = "latest"
  }
}
