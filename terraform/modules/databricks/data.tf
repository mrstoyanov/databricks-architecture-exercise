data "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "this" {
  for_each = toset([var.subnet_private_name, var.subnet_public_name])

  name                 = each.value
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}
