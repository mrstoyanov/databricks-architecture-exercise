resource "azurerm_virtual_network_peering" "transit_to_dst" {
  name                      = "transit_to_${var.vnet_dst_name}"
  resource_group_name       = "transit"
  virtual_network_name      = "transit"
  remote_virtual_network_id = data.azurerm_virtual_network.dst.id
  allow_gateway_transit     = true
}

resource "azurerm_virtual_network_peering" "dst_to_transit" {
  name                      = "${var.vnet_dst_name}_to_transit"
  resource_group_name       = var.resource_group_dst_name
  virtual_network_name      = var.vnet_dst_name
  remote_virtual_network_id = data.azurerm_virtual_network.transit.id
  use_remote_gateways       = true
}
