output "access_connector_id" {
  description = "ID of the Databricks Access Connector"
  value       = azurerm_databricks_access_connector.unity.id
}

output "access_connector_principal_id" {
  description = "Principal ID of the Access Connector managed identity"
  value       = azurerm_databricks_access_connector.unity.identity[0].principal_id
}

output "storage_account_id" {
  description = "ID of the Unity Catalog storage account"
  value       = azurerm_storage_account.unity_catalog.id
}

output "storage_account_name" {
  description = "Name of the Unity Catalog storage account"
  value       = azurerm_storage_account.unity_catalog.name
}

output "storage_account_primary_dfs_endpoint" {
  description = "Primary DFS endpoint for Unity Catalog storage"
  value       = azurerm_storage_account.unity_catalog.primary_dfs_endpoint
}

output "container_name" {
  description = "Name of the Unity Catalog container"
  value       = azurerm_storage_container.unity_catalog.name
}

output "metastore_storage_path" {
  description = "Storage path for Unity Catalog metastore"
  value       = "abfss://${azurerm_storage_container.unity_catalog.name}@${azurerm_storage_account.unity_catalog.name}.dfs.core.windows.net/"
}
