output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.test_vnet.id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.test_vnet.name
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = azurerm_subnet.databricks_public.id
}

output "public_subnet_name" {
  description = "Name of the public subnet"
  value       = azurerm_subnet.databricks_public.name
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = azurerm_subnet.databricks_private.id
}

output "private_subnet_name" {
  description = "Name of the private subnet"
  value       = azurerm_subnet.databricks_private.name
}

output "public_nsg_id" {
  description = "ID of the public NSG"
  value       = azurerm_network_security_group.databricks_public.id
}

output "private_nsg_id" {
  description = "ID of the private NSG"
  value       = azurerm_network_security_group.databricks_private.id
}
