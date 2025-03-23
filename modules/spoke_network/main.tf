resource "azurerm_virtual_network" "this" {
  count = length(var.vnet_address_spaces) > 0 ? 1 : 0
  
  name                = "${local.resource_prefix}-vnet"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [var.vnet_address_spaces]

  tags                = var.tags
}

resource "azurerm_subnet" "this" {
  count = length(var.subnet_names)
  name                 = "${var.subnet_names[count.index]}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this[0].name
  address_prefixes     = var.subnet_names != "" ? [cidrsubnet(var.vnet_address_spaces, 8, count.index + 1)] : [] # 10.0.0.0/16 => [10.0.1.0/24]
}

resource "azurerm_virtual_network_peering" "hub-to-spoke" {
  provider = azurerm.hub
  count                        = var.enable_vnet_peering ? 1 : 0
  name                          = "${data.azurerm_virtual_network.hub_virtual_network.name}-to-${azurerm_virtual_network.this[0].name}-peering"
  virtual_network_name          = data.azurerm_virtual_network.hub_virtual_network.name
  resource_group_name = data.azurerm_virtual_network.hub_virtual_network.resource_group_name
  remote_virtual_network_id     = azurerm_virtual_network.this[0].id
  allow_forwarded_traffic       = var.allow_forwarded_traffic
  allow_virtual_network_access  = var.allow_virtual_network_access
  allow_gateway_transit         = var.allow_gateway_transit
}

resource "azurerm_virtual_network_peering" "spoke-to-hub" {
  count                        = var.enable_vnet_peering ? 1 : 0

  name                          = "${azurerm_virtual_network.this[0].name}-to-${var.hub_virtual_network_name}-peering"
  virtual_network_name          = azurerm_virtual_network.this[0].name
  resource_group_name = azurerm_resource_group.this.name
  remote_virtual_network_id     = data.azurerm_virtual_network.hub_virtual_network.id
  allow_forwarded_traffic       = var.allow_forwarded_traffic
  allow_virtual_network_access  = var.allow_virtual_network_access
  allow_gateway_transit         = var.allow_gateway_transit

  depends_on = [ azurerm_virtual_network_peering.hub-to-spoke, azurerm_virtual_network.this ]
}

