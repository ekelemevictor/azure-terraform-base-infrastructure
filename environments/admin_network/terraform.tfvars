organization        = "dv"
environment         = "admin"
owner_name          = "thatSREguy"
vnet_address_spaces = "10.0.0.0/16"
location            = "EAST US"

subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
tenant_id       = "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy"

subnet_names = [
  "bastion-subnet",
  "firewall-subnet"
]
