provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group" {
  name = "rg-flex-scale"
  location = "Brazil South"
}

resource "azure_virtual_network" "AZN" {
  name = "VNet1"
  resource_group_name = azurerm_resource_group.resource_group.name
  location = azurerm_resource_group.resource_group.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.resource_group
  virtual_network_name = azurerm_virtual_network.AZN.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azure_network_interface" "NIC" {
  name = "Nic1"
  location = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name = "NicConfiguration"
    subnet_id  = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "VM" {
  name = "vm1"
  location = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  network_interface_ids = [azure_network_interface.id]
  vm_size = "Standard_DS1_v2"

  storage_os_disk {
    name = "OsDisk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "10.04-LTS"
    version = "latest"
  }

    os_profile {
    computer_name  = var.computer_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}