# Access Connector for Unity Catalog (Managed Identity)
resource "azurerm_databricks_access_connector" "unity" {
  name                = var.access_connector_name
  resource_group_name = var.resource_group_name
  location            = var.location

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# Storage Account for Unity Catalog Metastore
resource "azurerm_storage_account" "unity_catalog" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true # Required for Unity Catalog

  tags = var.tags
}

# Storage Container for Unity Catalog
resource "azurerm_storage_container" "unity_catalog" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.unity_catalog.name
  container_access_type = "private"
}

# Assign Storage Blob Data Contributor role to Access Connector
resource "azurerm_role_assignment" "unity_catalog" {
  scope                = azurerm_storage_account.unity_catalog.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.unity.identity[0].principal_id
}
