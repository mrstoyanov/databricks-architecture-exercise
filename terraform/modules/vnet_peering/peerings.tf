resource "azurerm_virtual_network_peering" "src_to_dst" {
  name                      = "${var.vnet_src_name}_to_${var.vnet_dst_name}"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.vnet_src_name
  remote_virtual_network_id = data.azurerm_virtual_network.dst.id
  allow_gateway_transit     = true
}

resource "azurerm_virtual_network_peering" "dst_to_src" {
  name                      = "${var.vnet_dst_name}_to_${var.vnet_src_name}"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.vnet_dst_name
  remote_virtual_network_id = data.azurerm_virtual_network.src.id
  use_remote_gateways       = true
}
