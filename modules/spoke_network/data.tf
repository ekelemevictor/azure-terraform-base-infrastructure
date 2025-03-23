data "azurerm_virtual_network" "hub_virtual_network" {
  provider = azurerm.hub
  name                = var.hub_virtual_network_name
  resource_group_name = var.hub_virtual_network_rg
}