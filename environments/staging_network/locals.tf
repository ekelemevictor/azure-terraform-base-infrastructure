locals {
  base_tags = {
    Owner   = var.owner_name
    Team    = "SRE OPS"
    TF_Repo = "TF_Base_Infrastructure/environments/staging_network"
  }
}