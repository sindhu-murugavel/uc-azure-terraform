resource "databricks_metastore_assignment" "example" {
  provider             = databricks.accounts
  workspace_id         = local.databricks_workspace_id
  metastore_id         = databricks_metastore.this.id
  default_catalog_name = "hive_metastore"
}