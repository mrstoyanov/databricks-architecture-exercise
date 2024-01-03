resource "azurerm_databricks_workspace" "this" {
  name                = var.databricks_workspace_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = var.sku

  custom_parameters {
    public_subnet_name                                   = var.subnet_public_name
    public_subnet_network_security_group_association_id  = data.azurerm_subnet.this[var.subnet_private_name].id
    private_subnet_name                                  = var.subnet_private_name
    private_subnet_network_security_group_association_id = data.azurerm_subnet.this[var.subnet_public_name].id
    storage_account_sku_name                             = var.storage_account_sku_name
    virtual_network_id                                   = data.azurerm_virtual_network.this.id
  }
}

resource "azurerm_route_table" "this" {
  name                = "Databricks"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  route {
    name           = "AzureDatabricks"
    address_prefix = "AzureDatabricks"
    next_hop_type  = "Internet"
  }
  route {
    name           = "Sql"
    address_prefix = "Sql"
    next_hop_type  = "Internet"
  }
  route {
    name           = "Storage"
    address_prefix = "Storage"
    next_hop_type  = "Internet"
  }
  route {
    name           = "EventHub"
    address_prefix = "EventHub"
    next_hop_type  = "Internet"
  }
  route {
    name           = "Extended_infrastructure"
    address_prefix = var.udr_extended_infrastructure
    next_hop_type  = "Internet"
  }
  route {
    name           = "Control_Plane_NAT"
    address_prefix = var.udr_control_plane_nat
    next_hop_type  = "Internet"
  }
  route {
    name           = "WebApp"
    address_prefix = var.udr_webapp
    next_hop_type  = "Internet"
  }
}

resource "azurerm_subnet_route_table_association" "this" {
  for_each = toset([var.subnet_public_name, var.subnet_private_name])

  subnet_id      = data.azurerm_subnet.this[each.key].id
  route_table_id = azurerm_route_table.this.id
}
