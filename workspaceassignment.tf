
/*resource "databricks_metastore" "this" {
  name          = "wegmans-metastore"
  storage_root  = "abfss://wegmansuc-container@wegmansucstorage.dfs.core.windows.net/"
  force_destroy = true
  region        = data.azurerm_resource_group.existing_rg.location
}*/

resource "databricks_metastore_assignment" "example" {
  provider             = databricks.accounts
  workspace_id         = data.azurerm_databricks_workspace.this.workspace_id
  metastore_id         = databricks_metastore.this.id
  default_catalog_name = "hive_metastore"
}


resource "databricks_metastore_assignment" "dummy" {
  provider             = databricks.accounts
  workspace_id         = data.azurerm_databricks_workspace.dummy.workspace_id
  metastore_id         = databricks_metastore.this.id
  default_catalog_name = "hive_metastore"
}
