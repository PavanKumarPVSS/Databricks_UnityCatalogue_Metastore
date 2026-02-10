output "storage_account_id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.storage.id
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.storage.name
}

output "primary_blob_endpoint" {
  description = "Primary blob endpoint"
  value       = azurerm_storage_account.storage.primary_blob_endpoint
}

output "primary_queue_endpoint" {
  description = "Primary queue endpoint"
  value       = azurerm_storage_account.storage.primary_queue_endpoint
}

output "primary_table_endpoint" {
  description = "Primary table endpoint"
  value       = azurerm_storage_account.storage.primary_table_endpoint
}

output "primary_file_endpoint" {
  description = "Primary file endpoint"
  value       = azurerm_storage_account.storage.primary_file_endpoint
}

output "primary_access_key" {
  description = "Primary access key"
  value       = azurerm_storage_account.storage.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "Secondary access key"
  value       = azurerm_storage_account.storage.secondary_access_key
  sensitive   = true
}

output "primary_connection_string" {
  description = "Primary connection string"
  value       = azurerm_storage_account.storage.primary_connection_string
  sensitive   = true
}

output "secondary_connection_string" {
  description = "Secondary connection string"
  value       = azurerm_storage_account.storage.secondary_connection_string
  sensitive   = true
}

output "container_names" {
  description = "Names of created containers"
  value       = [for c in azurerm_storage_container.containers : c.name]
}

output "queue_names" {
  description = "Names of created queues"
  value       = [for q in azurerm_storage_queue.queues : q.name]
}

output "table_names" {
  description = "Names of created tables"
  value       = [for t in azurerm_storage_table.tables : t.name]
}

output "file_share_names" {
  description = "Names of created file shares"
  value       = [for s in azurerm_storage_share.shares : s.name]
}
