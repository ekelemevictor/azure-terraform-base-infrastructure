output "virtual_network_id" {
  description = "The ID of the created vnet."
  value = azurerm_virtual_network.this[0].id
}

output "virtual_network_name" {
  description = "The ID of the created vnet."
  value = azurerm_virtual_network.this[0].name
}

output "virtual_network_rg" {
  description = "The ID of the created vnet."
  value = azurerm_virtual_network.this[0].resource_group_name
}

output "subnet_ids" {
  description = "The IDs of the created subnets."
  value = { for key, subnet in azurerm_subnet.this : key => subnet.id }
}

output "subnet_names" {
  description = "The names of the created subnets."
  value = { for key, subnet in azurerm_subnet.this : key => subnet.name }
}

output "subnet_address_prefixes" {
  description = "The address prefixes assigned to each subnet."
  value = { for key, subnet in azurerm_subnet.this : key => subnet.address_prefixes }
}
