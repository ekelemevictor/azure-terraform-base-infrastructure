# ========================================
# Organization and Ownership Variables
# ========================================
variable "organization" {
  description = "The name of the organization used as part of resource naming."
  type        = string
  default     = "dv"
}

variable "owner_name" {
  description = "The owner of the deployed resources."
  type        = string
  default     = "Victor Ekeleme"
}

# ========================================
# Subscription and Tenant Configuration
# ========================================
variable "hub_subscription_id" {
  description = "The subscription ID for the management (hub) environment."
  type        = string
}

variable "subscription_id" {
  description = "The subscription ID for the development environment."
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID for the management (hub) environment."
  type        = string
}

# ========================================
# Virtual Network and Subnet Configuration
# ========================================
# VNet Address Spaces per Environment
variable "vnet_address_spaces" {
  description = "The address space for the development virtual network."
  type        = string
  default     = "10.1.0.0/16"
}

variable "subnet_names" {
  description = "A map of subnet names"
  type        = list(string)
  default = [
    "dev-subnet-1",
    "dev-subnet-2"
  ]
}

# ========================================
# Virtual Network Peering
# ========================================
variable "hub_virtual_network_name" {
  description = "The name of the existing Hub Virtual Network (VNet) to peer with."
  type        = string
}

variable "hub_virtual_network_rg" {
  description = "The name of the Resource Group where the Hub Virtual Network resides."
  type        = string
}

# ========================================
# Environment Configuration
# ========================================
variable "environment" {
  description = "The environment where resources will be deployed (e.g. dev, staging, prod)."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Invalid environment selection. Choose one of: dev, staging, prod."
  }
}

# ========================================
# Private DNS Configuration
# ========================================
# variable "private_dns_zone_vnet_link" {
#   description = "A list of Private DNS Zone names to be created."
#   type        = list(string)
# }

# ========================================
# Azure Identity Variables
# ========================================
variable "owner_object_id" {
  description = "The Azure AD Object ID of the Key Vault owner."
  type        = string
}

# ========================================
# Location and Tagging Configuration
# ========================================
variable "location" {
  description = "The Azure region for deploying resources (e.g., eastus, westus)."
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to all resources (e.g., {Project = 'TF_Infra', Owner = 'Victor'})."
  type        = map(string)
  default     = {}
}