module "virtual_network_hub" {
  providers = {
    azurerm = azurerm.hub
  }
  source              = "../../modules/hub_network"
  organization        = var.organization
  vnet_address_spaces = var.vnet_address_spaces
  subnet_names        = var.subnet_names
  environment         = var.environment
  location            = var.location

  tags = merge(local.base_tags, {
    environment = var.environment
    TF_Module   = "TF_Network_Base/modules/hub_network"
  })
}