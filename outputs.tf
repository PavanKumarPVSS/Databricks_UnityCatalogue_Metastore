# ========================================
# Resource Group Outputs
# ========================================

output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.resource_group.resource_group_name
}

output "resource_group_id" {
  description = "ID of the resource group"
  value       = module.resource_group.resource_group_id
}

output "resource_group_location" {
  description = "Location of the resource group"
  value       = module.resource_group.resource_group_location
}

# ========================================
# Virtual Network Outputs
# ========================================

output "vnet_id" {
  description = "ID of the virtual network"
  value       = module.vnet.vnet_id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = module.vnet.vnet_name
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.vnet.public_subnet_id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = module.vnet.private_subnet_id
}

# ========================================
# Storage Account Outputs
# ========================================

output "storage_account_id" {
  description = "ID of the storage account"
  value       = module.storage_account.storage_account_id
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = module.storage_account.storage_account_name
}

output "storage_primary_blob_endpoint" {
  description = "Primary blob endpoint"
  value       = module.storage_account.primary_blob_endpoint
}

# ========================================
# Databricks Outputs
# ========================================

output "databricks_workspace_id" {
  description = "ID of the Databricks workspace"
  value       = module.databricks.workspace_id
}

output "databricks_workspace_name" {
  description = "Name of the Databricks workspace"
  value       = module.databricks.workspace_name
}

output "databricks_workspace_url" {
  description = "URL of the Databricks workspace"
  value       = module.databricks.workspace_url
}

output "databricks_workspace_id_value" {
  description = "Unique identifier of the Databricks workspace"
  value       = module.databricks.workspace_id_value
}

output "databricks_managed_resource_group_id" {
  description = "ID of the Databricks managed resource group"
  value       = module.databricks.managed_resource_group_id
}

# ========================================
# Unity Catalog Outputs
# ========================================

output "unity_catalog_access_connector_id" {
  description = "ID of the Unity Catalog access connector"
  value       = module.unity_catalog.access_connector_id
}

output "unity_catalog_access_connector_principal_id" {
  description = "Principal ID of the Unity Catalog access connector"
  value       = module.unity_catalog.access_connector_principal_id
  sensitive   = true
}

output "unity_catalog_storage_account_id" {
  description = "ID of the Unity Catalog storage account"
  value       = module.unity_catalog.storage_account_id
}

output "unity_catalog_storage_account_name" {
  description = "Name of the Unity Catalog storage account"
  value       = module.unity_catalog.storage_account_name
}

output "unity_catalog_metastore_storage_path" {
  description = "Storage path for Unity Catalog metastore"
  value       = module.unity_catalog.metastore_storage_path
}
