resource "databricks_catalog" "sandbox" {
  provider     = databricks.workspace
  metastore_id = databricks_metastore.this.id
  name         = "sandbox"
  comment      = "this catalog is managed by terraform"
  properties = {
    purpose = "testing"
  }
}
data "azurerm_storage_account" "example" {
  name                = "wegmansstg"
  resource_group_name = data.azurerm_resource_group.existing_rg.name
}

data "azurerm_storage_container" "example" {
  name                 = "mycontainer"
  storage_account_name = data.azurerm_storage_account.example.name

}


resource "databricks_external_location" "schemaloc" {
  name = "notroot"
  url = format("abfss://%s@%s.dfs.core.windows.net",
    data.azurerm_storage_container.example.name,
  data.azurerm_storage_account.example.name)
  credential_name = databricks_metastore_data_access.first.name

  comment = "Managed by TF"

}

resource "databricks_schema" "things" {
  catalog_name = databricks_catalog.sandbox.id
  name         = "myschema"
  comment      = "this database is managed by terraform"
  storage_root = databricks_external_location.schemaloc.url
  properties = {
    kind = "various"
  }
}