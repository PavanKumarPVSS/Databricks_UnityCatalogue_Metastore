# ========================================
# General Configuration
# ========================================
location = "East US"

tags = {
  Environment = "Development"
  Project     = "Databricks-Deployment"
  ManagedBy   = "Terraform"
  Owner       = "DataEngineering"
}

# ========================================
# Resource Group
# ========================================
resource_group_name = "rg-databricks-prod"

# ========================================
# Virtual Network
# ========================================
vnet_name             = "vnet-databricks"
vnet_address_space    = ["10.0.0.0/16"]
public_subnet_name    = "databricks-public-subnet"
private_subnet_name   = "databricks-private-subnet"
public_subnet_prefix  = ["10.0.1.0/24"]
private_subnet_prefix = ["10.0.2.0/24"]

# ========================================
# Storage Account
# ========================================
storage_account_name                    = "stdatabricksprod001"
storage_account_tier                    = "Standard"
storage_replication_type                = "LRS"
storage_account_kind                    = "StorageV2"
storage_enable_https_traffic_only       = true
storage_min_tls_version                 = "TLS1_2"
storage_allow_public_access             = false
storage_public_network_access_enabled   = true
storage_enable_blob_properties          = true
storage_blob_versioning_enabled         = true
storage_blob_change_feed_enabled        = false
storage_blob_last_access_time_enabled   = false
storage_blob_delete_retention_days      = 7
storage_container_delete_retention_days = 7
storage_enable_network_rules            = false
storage_network_rules_default_action    = "Deny"
storage_network_rules_ip_rules          = []
storage_network_rules_subnet_ids        = []
storage_network_rules_bypass            = ["AzureServices"]

# Example blob containers
storage_containers = {
  "data" = {
    access_type = "private"
  }
  "logs" = {
    access_type = "private"
  }
}

# Example queues, tables, and file shares
storage_queues = []
storage_tables = []
storage_file_shares = {}

# ========================================
# Databricks Workspace
# ========================================
databricks_workspace_name                = "dbw-prod-001"
databricks_sku                           = "premium"
databricks_public_network_access_enabled = false
databricks_nsg_rules_required            = "NoAzureDatabricksRules"
databricks_no_public_ip                  = true

# ========================================
# Unity Catalog
# ========================================
unity_catalog_access_connector_name = "dbw-unity-access-connector"
unity_catalog_storage_account_name  = "stunitycatalog001"
unity_catalog_container_name        = "unity-catalog"
