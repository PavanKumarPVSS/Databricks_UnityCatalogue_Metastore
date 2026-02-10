############################################
# Environment / Naming
############################################
variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
}

variable "location" {
  description = "Azure region (must match Databricks workspace region)"
  type        = string
}

############################################
# Databricks Workspace
############################################
variable "workspace_url" {
  description = "Databricks workspace URL"
  type        = string
}

variable "workspace_id" {
  description = "Databricks workspace ID"
  type        = string
}

############################################
# Unity Catalog Storage (Azure-side outputs)
############################################
variable "access_connector_id" {
  description = "Resource ID of the Databricks Access Connector"
  type        = string
}

variable "storage_account_name" {
  description = "Storage account name used for Unity Catalog"
  type        = string
}

variable "container_name" {
  description = "Storage container name for Unity Catalog metastore root"
  type        = string
}
