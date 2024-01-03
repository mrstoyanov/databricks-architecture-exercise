data "azurerm_virtual_network" "transit" {
  name                = "transit"
  resource_group_name = "transit"
}

data "azurerm_virtual_network" "dst" {
  name                = var.vnet_dst_name
  resource_group_name = var.resource_group_dst_name
}
