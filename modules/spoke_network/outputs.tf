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

output "vnet_peering_info" {
  value = {
    "hub-to-spoke" = {
      name                         = try(azurerm_virtual_network_peering.hub-to-spoke[0].name, null)
      resource_group_name          = try(azurerm_virtual_network_peering.hub-to-spoke[0].resource_group_name, null)
      virtual_network_name         = try(azurerm_virtual_network_peering.hub-to-spoke[0].virtual_network_name, null)
      remote_virtual_network_id    = try(azurerm_virtual_network_peering.hub-to-spoke[0].remote_virtual_network_id, null)
      allow_forwarded_traffic      = try(azurerm_virtual_network_peering.hub-to-spoke[0].allow_forwarded_traffic, null)
      allow_virtual_network_access = try(azurerm_virtual_network_peering.hub-to-spoke[0].allow_virtual_network_access, null)
      allow_gateway_transit        = try(azurerm_virtual_network_peering.hub-to-spoke[0].allow_gateway_transit, null)
    }

    "spoke-to-hub" = {
      name                         = try(azurerm_virtual_network_peering.spoke-to-hub[0].name, null)
      resource_group_name          = try(azurerm_virtual_network_peering.spoke-to-hub[0].resource_group_name, null)
      virtual_network_name         = try(azurerm_virtual_network_peering.spoke-to-hub[0].virtual_network_name, null)
      remote_virtual_network_id    = try(azurerm_virtual_network_peering.spoke-to-hub[0].remote_virtual_network_id, null)
      allow_forwarded_traffic      = try(azurerm_virtual_network_peering.spoke-to-hub[0].allow_forwarded_traffic, null)
      allow_virtual_network_access = try(azurerm_virtual_network_peering.spoke-to-hub[0].allow_virtual_network_access, null)
      allow_gateway_transit        = try(azurerm_virtual_network_peering.spoke-to-hub[0].allow_gateway_transit, null)
    }
  }

  description = "Details of the created Hub-to-Spoke and Spoke-to-Hub Virtual Network Peerings"
}
