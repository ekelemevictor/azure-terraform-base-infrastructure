locals {
  # Prefix for resource naming, ensuring consistency across resources
  resource_prefix = "${var.organization}-${var.environment}-${local.location}"

  normalized_location = replace(lower(var.location), " ", "") # EAST US >> eastus
  location = lookup(local.azure_location_map, var.location, local.normalized_location)
  
  azure_location_map = {
    "East US"    = "eastus"
    "East US 2"  = "eastus2"
    "West US"    = "westus"
    "West US 2"  = "westus2"
  }
}

