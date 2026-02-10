output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.rg_testing.name
}

output "resource_group_id" {
  description = "ID of the resource group"
  value       = azurerm_resource_group.rg_testing.id
}

output "resource_group_location" {
  description = "Location of the resource group"
  value       = azurerm_resource_group.rg_testing.location
}
