data "azurerm_virtual_network" "src" {
  name                = var.vnet_src_name
  resource_group_name = var.resource_group_name
}

data "azurerm_virtual_network" "dst" {
  name                = var.vnet_dst_name
  resource_group_name = var.resource_group_name
}
