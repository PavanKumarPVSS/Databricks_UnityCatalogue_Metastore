############################################
# Databricks Provider (Workspace scoped)
############################################
provider "databricks" {
  host = var.workspace_url
}

############################################
# Unity Catalog Metastore
############################################
resource "databricks_metastore" "unity" {
  name   = "uc-metastore-${var.environment}"
  region = var.location

  storage_root = "abfss://${var.container_name}@${var.storage_account_name}.dfs.core.windows.net/"

  owner = "account-admins"
}

############################################
# Bind Metastore to Workspace
############################################
resource "databricks_metastore_assignment" "this" {
  workspace_id = var.workspace_id
  metastore_id = databricks_metastore.unity.id
}
