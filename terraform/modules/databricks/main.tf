resource "azurerm_databricks_workspace" "this" {
  name                = var.databricks_workspace_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = var.sku

  custom_parameters {
    public_subnet_name = var.subnet_public_name
    public_subnet_network_security_group_association_id = data.azurerm_subnet.this[var.subnet_private_name].id
    private_subnet_name = var.subnet_private_name
    private_subnet_network_security_group_association_id = data.azurerm_subnet.this[var.subnet_public_name].id
    storage_account_sku_name = var.storage_account_sku_name
    virtual_network_id = data.azurerm_virtual_network.this.id

  }

}
