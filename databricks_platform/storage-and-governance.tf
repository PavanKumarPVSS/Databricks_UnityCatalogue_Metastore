############################################
# Storage Credential (Uses Access Connector)
############################################
resource "databricks_storage_credential" "unity" {
  name = "uc-storage-credential-${var.environment}"

  azure_managed_identity {
    access_connector_id = var.access_connector_id
  }

  owner = "account-admins"
}

############################################
# External Location (UC-governed access)
############################################
resource "databricks_external_location" "unity_root" {
  name            = "uc-root-location-${var.environment}"
  url             = "abfss://${var.container_name}@${var.storage_account_name}.dfs.core.windows.net/"
  credential_name = databricks_storage_credential.unity.name

  owner = "account-admins"
}
