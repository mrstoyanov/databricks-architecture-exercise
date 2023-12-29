# Gateway and public IP
resource "azurerm_public_ip" "this" {
  name                = "GatewayIP"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "this" {
  name                = "Gateway"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  generation = "Generation1"
  type       = "Vpn"
  sku        = "Basic"

  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.this.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = data.azurerm_subnet.this.id
  }
}

# Remote imaginary (on-prem) gateway
resource "azurerm_local_network_gateway" "this" {
  name                = "OnPremises"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  gateway_address = "12.13.14.15"
  address_space   = ["172.16.0.0/16"]
}

# IPsec config to establish a tunnel to the imaginary remote gateway
# Phase 1 and Phase 2 parameters:
# https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpn-devices#ipsec
resource "azurerm_virtual_network_gateway_connection" "onpremise" {
  name                = "Azure_to_OnPremises"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.this.id
  local_network_gateway_id   = azurerm_local_network_gateway.this.id

  shared_key = var.ipsec_preshared_key
}
