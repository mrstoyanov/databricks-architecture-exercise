data "azurerm_client_config" "current" {}

data "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"
  virtual_network_name = "transit"
  resource_group_name  = var.resource_group_name
}

data "azurerm_subnet" "private_endpoint" {
  name                 = var.private_endpoint_subnet_name
  virtual_network_name = "transit"
  resource_group_name  = var.resource_group_name
}

data "azurerm_storage_account" "this" {
  count = var.enable_private_endpoint ? 1: 0
  
  name                = var.private_connection_storage_name
  resource_group_name = var.resource_group_name
}
