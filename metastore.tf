resource "databricks_metastore" "this" {
  provider = databricks.accounts
  name     = "wegmans-metastore"
  storage_root = format("abfss://%s@%s.dfs.core.windows.net/",
    azurerm_storage_container.unity_catalog.name,
  azurerm_storage_account.unity_catalog.name)
  force_destroy = true
  region        = data.azurerm_resource_group.existing_rg.location
}

resource "databricks_metastore_data_access" "first" {
  provider     = databricks.accounts
  metastore_id = databricks_metastore.this.id
  name         = "wegmans-keys"
  azure_managed_identity {
    access_connector_id = azurerm_databricks_access_connector.unity.id
    managed_identity_id = azurerm_user_assigned_identity.example.id

  }

  is_default = true
}

output "databricks_metastore_id" {
  value = databricks_metastore_data_access.first.name

}
