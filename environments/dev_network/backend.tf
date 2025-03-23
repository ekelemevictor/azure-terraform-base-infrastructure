terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "thatsreguytfstatefilesa"
    container_name       = "tfstate"
    key                  = "dev-network/terraform.tfstate"
  }
}
