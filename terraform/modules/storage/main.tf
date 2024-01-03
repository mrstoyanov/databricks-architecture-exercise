resource "random_string" "this" {
  length  = 10
  special = false
  upper   = false
  lower   = false
  numeric = true
}

resource "azurerm_storage_account" "this" {
  name                     = "${var.storage_account_prefix}${random_string.this.result}"
  location                 = var.resource_group_location
  resource_group_name      = var.resource_group_name
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
}

resource "azurerm_storage_container" "this" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}
