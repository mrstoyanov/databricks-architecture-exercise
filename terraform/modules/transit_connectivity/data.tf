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
