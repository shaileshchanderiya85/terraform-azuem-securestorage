terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.17.0"
    }

  }
}

locals {
  tags = {
    "Environment" = var.environment
  }
}


resource "azurerm_storage_account" "securestorage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.tags
}

resource "azurerm_resource_group" "practicesaz305" {
  name     = var.resource_group_name
  location = var.location
}


resource "azurerm_virtual_network" "practicesaz305" {
  name                = "practicesaz305-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.practicesaz305.location
  resource_group_name = azurerm_resource_group.practicesaz305.name
}

resource "azurerm_subnet" "practicesaz305" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.practicesaz305.name
  virtual_network_name = azurerm_virtual_network.practicesaz305.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "practicesaz305" {
  name                = "practicesaz305-nic"
  location            = azurerm_resource_group.practicesaz305.location
  resource_group_name = azurerm_resource_group.practicesaz305.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.practicesaz305.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "practicesaz305" {
  name                = "practicesaz305-machine"
  resource_group_name = azurerm_resource_group.practicesaz305.name
  location            = azurerm_resource_group.practicesaz305.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.practicesaz305.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}