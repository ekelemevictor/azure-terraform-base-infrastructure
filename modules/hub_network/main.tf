resource "azurerm_virtual_network" "this" {
  count = (var.vnet_address_spaces == null ||  var.vnet_address_spaces == "") ? 0 : 1
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
