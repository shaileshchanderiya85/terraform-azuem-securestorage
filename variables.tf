variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account."

}

variable "name" {
  type        = string
  description = "The name of the storage account. Storage account names must be between 3 and 24 characters in length and may contain numbers and lowercase letters only."

}

variable "location" {
  type        = string
  description = "The Azure region where the storage account will be created."

}

variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
}

variable "storage_account_name" {
  type        = string
  description = "The name of the storage account. Storage account names must be between 3 and 24 characters in length and may contain numbers and lowercase letters only."

}
