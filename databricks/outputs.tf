output "workspace_id" {
  description = "ID of the Databricks workspace"
  value       = azurerm_databricks_workspace.databricks_workspace_testing.id
}

output "workspace_name" {
  description = "Name of the Databricks workspace"
  value       = azurerm_databricks_workspace.databricks_workspace_testing.name
}

output "workspace_url" {
  description = "URL of the Databricks workspace"
  value       = azurerm_databricks_workspace.databricks_workspace_testing.workspace_url
}

output "workspace_id_value" {
  description = "Unique identifier of the workspace"
  value       = azurerm_databricks_workspace.databricks_workspace_testing.workspace_id
}

output "managed_resource_group_id" {
  description = "ID of the managed resource group"
  value       = azurerm_databricks_workspace.databricks_workspace_testing.managed_resource_group_id
}
