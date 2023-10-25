resource "azurerm_user_assigned_identity" "example" {
  location            = data.azurerm_resource_group.existing_rg.location
  name                = "wegmansuc-user-mi"
  resource_group_name = data.azurerm_resource_group.existing_rg.name
}


resource "azurerm_databricks_access_connector" "unity" {
  name                = "wegmansuc-databricks-connector"
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  location            = data.azurerm_resource_group.existing_rg.location
  identity {
    //type = "SystemAssigned"
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.example.id]
  }
}
resource "azurerm_role_assignment" "example" {
  scope                = azurerm_storage_account.unity_catalog.id
  role_definition_name = "Storage Blob Data Contributor"
  //principal_id         = azurerm_databricks_access_connector.unity.identity[0].principal_id
  principal_id = azurerm_user_assigned_identity.example.principal_id
}