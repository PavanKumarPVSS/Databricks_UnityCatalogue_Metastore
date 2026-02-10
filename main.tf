# ========================================
# Module: Resource Group
# ========================================
module "resource_group" {
  source = "./resource_group"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

# ========================================
# Module: Virtual Network
# ========================================
module "vnet" {
  source = "./vnet"

  vnet_name             = var.vnet_name
  location              = module.resource_group.resource_group_location
  resource_group_name   = module.resource_group.resource_group_name
  address_space         = var.vnet_address_space
  public_subnet_name    = var.public_subnet_name
  private_subnet_name   = var.private_subnet_name
  public_subnet_prefix  = var.public_subnet_prefix
  private_subnet_prefix = var.private_subnet_prefix
  tags                  = var.tags

  depends_on = [module.resource_group]
}

# ========================================
# Module: Storage Account
# ========================================
module "storage_account" {
  source = "./storage_account"

  storage_account_name            = var.storage_account_name
  resource_group_name             = module.resource_group.resource_group_name
  location                        = module.resource_group.resource_group_location
  account_tier                    = var.storage_account_tier
  replication_type                = var.storage_replication_type
  account_kind                    = var.storage_account_kind
  enable_https_traffic_only       = var.storage_enable_https_traffic_only
  min_tls_version                 = var.storage_min_tls_version
  allow_public_access             = var.storage_allow_public_access
  public_network_access_enabled   = var.storage_public_network_access_enabled
  enable_blob_properties          = var.storage_enable_blob_properties
  blob_versioning_enabled         = var.storage_blob_versioning_enabled
  blob_change_feed_enabled        = var.storage_blob_change_feed_enabled
  blob_last_access_time_enabled   = var.storage_blob_last_access_time_enabled
  blob_delete_retention_days      = var.storage_blob_delete_retention_days
  container_delete_retention_days = var.storage_container_delete_retention_days
  enable_network_rules            = var.storage_enable_network_rules
  network_rules_default_action    = var.storage_network_rules_default_action
  network_rules_ip_rules          = var.storage_network_rules_ip_rules
  network_rules_subnet_ids        = var.storage_network_rules_subnet_ids
  network_rules_bypass            = var.storage_network_rules_bypass
  containers                      = var.storage_containers
  queues                          = var.storage_queues
  tables                          = var.storage_tables
  file_shares                     = var.storage_file_shares
  tags                            = var.tags

  depends_on = [module.resource_group]
}

# ========================================
# Module: Databricks Workspace
# ========================================
module "databricks" {
  source = "./databricks"

  workspace_name                        = var.databricks_workspace_name
  resource_group_name                   = module.resource_group.resource_group_name
  location                              = module.resource_group.resource_group_location
  sku                                   = var.databricks_sku
  public_network_access_enabled         = var.databricks_public_network_access_enabled
  network_security_group_rules_required = var.databricks_nsg_rules_required
  no_public_ip                          = var.databricks_no_public_ip
  virtual_network_id                    = module.vnet.vnet_id
  public_subnet_name                    = module.vnet.public_subnet_name
  private_subnet_name                   = module.vnet.private_subnet_name
  public_subnet_nsg_association_id      = module.vnet.public_nsg_id
  private_subnet_nsg_association_id     = module.vnet.private_nsg_id
  tags                                  = var.tags

  depends_on = [module.resource_group, module.vnet]
}

# ========================================
# Module: Unity Catalog
# ========================================
module "unity_catalog" {
  source = "./unity_catalog"

  access_connector_name = var.unity_catalog_access_connector_name
  resource_group_name   = module.resource_group.resource_group_name
  location              = module.resource_group.resource_group_location
  storage_account_name  = var.unity_catalog_storage_account_name
  container_name        = var.unity_catalog_container_name
  tags                  = var.tags

  depends_on = [module.resource_group, module.databricks]
}
