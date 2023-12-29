resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
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

# Note: Custom DNS config is (in my view) out of scope for this exercise
resource "azurerm_private_endpoint" "this" {
  count = var.enable_private_endpoint ? 1: 0
  
  name                = "Storage"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.this.id

  private_service_connection {
    name                           = "Storage"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}
