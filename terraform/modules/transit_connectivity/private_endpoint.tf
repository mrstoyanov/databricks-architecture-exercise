# Note: Custom DNS config is (in my view) out of scope for this exercise
resource "azurerm_private_endpoint" "this" {
  for_each = { for idx, id in var.private_connection_storage_account_id : idx => id }

  name                = "Storate-${each.key}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.private_endpoint.id

  private_service_connection {
    name                           = "Storage"
    private_connection_resource_id = each.value
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}
