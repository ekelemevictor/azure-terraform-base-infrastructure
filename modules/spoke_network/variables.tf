# Organization-related variables
variable "organization" {
  description = "The name of the organization used as part of resource naming."
  type        = string
  default = ""

}

variable "owner_name" {
  description = "The owner of the deployed resources."
  type        = string
  default = ""

}

# Virtual network address space configuration
variable "vnet_address_spaces" {
  description = "The list of address spaces for the virtual network (e.g., ['10.0.0.0/16'])."
  type        = string
  default = ""
}

variable "subnet_names" {
  description = "Map of subnets with their respective address spaces."
  type        = list(string)
  
  default = []

  validation {
    condition     = length(var.subnet_names) > 0
    error_message = "You must define at least one subnet in subnet_names."
  }
}


# Environment selection with validation
variable "environment" {
  description = "The environment where resources will be deployed (e.g., mgmt, dev, staging, prod)."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Invalid environment selection. Choose one of: mgmt, dev, staging, prod."
  }
}

# Location variable with optional empty default
variable "location" {
  description = "The Azure region for deploying resources (e.g., EAST US, WEST US)."
  type        = string
  default = ""
}

# Tagging system with a default empty map for flexibility
variable "tags" {
  description = "A map of tags to apply to all resources (e.g., {Project = 'TF_Infra', Owner = 'Victor'})."
  type        = map(string)
  default = {}
}

variable "hub_virtual_network_name" {
  description = "The name of the existing Hub Virtual Network (VNet) to peer with."
  type        = string
}

variable "hub_virtual_network_rg" {
  description = "The name of the Resource Group where the Hub Virtual Network resides."
  type        = string
}

# Source Virtual Network variable with optional empty default
variable "source_virtual_network_name" {
  description = "The name of the source Azure Virtual Network. Leave empty if no source network is specified."
  type        = string
  default     = ""
}

# Source Virtual Network Resrouce group variable with optional empty default
variable "source_virtual_network_rg" {
  description = "The name of the source Azure Virtual Network Resource. Leave empty if no source network is specified."
  type        = string
  default     = ""
}


# Allow forwarded traffic between virtual networks
variable "allow_forwarded_traffic" {
  description = "Indicates whether forwarded traffic is allowed between virtual networks."
  type        = bool
  default     = true
}

# Allow virtual network access
variable "allow_virtual_network_access" {
  description = "Indicates whether virtual network access is allowed between connected networks."
  type        = bool
  default     = true
}

# Allow gateway transit
variable "allow_gateway_transit" {
  description = "Indicates whether the gateway transit feature is enabled for peered virtual networks."
  type        = bool
  default     = false
}

variable "enable_vnet_peering" {
  description = "Specifies whether Virtual Network (VNet) peering is enabled between the peered VNets."
  type        = bool
  default     = true
}

