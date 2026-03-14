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