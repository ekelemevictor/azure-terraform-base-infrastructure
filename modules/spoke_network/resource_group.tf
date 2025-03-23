resource "azurerm_resource_group" "this" {
  name     = "${local.resource_prefix}-vnet-rg"
  location = local.location
  tags = var.tags
}
