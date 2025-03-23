organization        = "dv"
environment         = "dev"
owner_name          = "thatSREguy"
vnet_address_spaces = "10.1.0.0/16"
location            = "EAST US"

hub_virtual_network_name = "dv-admin-eastus-vnet"
hub_virtual_network_rg   = "dv-admin-eastus-vnet-rg"

hub_subscription_id = "aaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
subscription_id     = "bbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"

subnet_names = [
  "web-subnet",
  "db-subnet",
]
