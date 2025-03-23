module "virtual_network_spoke" {
  providers = {
    azurerm     = azurerm.this
    azurerm.hub = azurerm.hub
  }
  source                   = "../../modules/spoke_network"
  organization             = var.organization
  environment              = var.environment
  location                 = var.location
  enable_vnet_peering      = true
  hub_virtual_network_name = var.hub_virtual_network_name
  hub_virtual_network_rg   = var.hub_virtual_network_rg

  vnet_address_spaces = var.vnet_address_spaces
  subnet_names        = var.subnet_names

  tags = merge(local.base_tags, {
    environment = var.environment
    TF_Module   = "TF_Network_Base/modules/spoke_network"
  })
}