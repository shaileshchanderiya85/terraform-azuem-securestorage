output "storage_account_id" {
    value = azurerm_storage_account.securestorage.id
    description = "The ID of the created storage account." 

}

output "name" {
    value = azurerm_storage_account.securestorage.name
    description = "The name of the created storage account."

}