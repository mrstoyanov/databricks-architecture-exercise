resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}

resource "azurerm_subnet" "this" {
  for_each = local.subnet_names_prefixes_map

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value]
  service_endpoints    = lookup(var.subnet_service_endpoints, each.key, [])

  dynamic "delegation" {
    for_each = var.service_delegation != "" ? [true] : []

    content {
      name = "service-delegation"

      service_delegation {
        actions = var.service_delegated_actions
        name    = var.service_delegation
      }
    }
  }
}

resource "azurerm_network_security_group" "this" {
  for_each = { 
    for subnet, prefix in local.subnet_names_prefixes_map : subnet => prefix 
    if subnet != "GatewaySubnet"
  }

  name                = each.key
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = { 
    for subnet, prefix in local.subnet_names_prefixes_map : subnet => prefix 
    if subnet != "GatewaySubnet"
  }

  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this[each.key].id
}
