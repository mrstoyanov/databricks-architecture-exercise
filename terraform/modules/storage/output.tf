output "storage_account_name" {
  description = "The storage account properties."
  value       = azurerm_storage_account.this.name
}

output "storage_account_id" {
  description = "The storage account properties."
  value       = azurerm_storage_account.this.id
}
