############################################
# Unity Catalog Outputs
############################################
output "metastore_id" {
  description = "Unity Catalog metastore ID"
  value       = databricks_metastore.unity.id
}

output "metastore_name" {
  description = "Unity Catalog metastore name"
  value       = databricks_metastore.unity.name
}

############################################
# Storage & Governance
############################################
output "storage_credential_name" {
  description = "Unity Catalog storage credential name"
  value       = databricks_storage_credential.unity.name
}

output "external_location_name" {
  description = "Unity Catalog external location name"
  value       = databricks_external_location.unity_root.name
}

output "external_location_url" {
  description = "External location ADLS URL"
  value       = databricks_external_location.unity_root.url
}
