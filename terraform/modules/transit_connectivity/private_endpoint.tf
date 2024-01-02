# Note: Custom DNS config is (in my view) out of scope for this exercise
resource "azurerm_private_endpoint" "this" {
  count = var.enable_private_endpoint ? 1: 0
  
  name                = "Storage"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.private_endpoint.id

  private_service_connection {
    name                           = "Storage"
    private_connection_resource_id = data.azurerm_storage_account.this[0].id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}
