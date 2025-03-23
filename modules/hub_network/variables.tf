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
  description = "List subnets with their respective address spaces."
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
    condition     = contains(["admin", "management"], var.environment)
    error_message = "Invalid environment selection. Choose one of: mgmt, dev, staging, prod, dev-aks, staging-aks, prod-aks."
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



