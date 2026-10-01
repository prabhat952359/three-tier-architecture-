resource "azurerm_postgresql_flexible_server" "postgres" {
    for_each = var.postgres
  name                          = each.value.postgres_name
  resource_group_name           = each.value.resource_group_name
  location                      = each.value.location
  version                       = "11"
  public_network_access_enabled = true
  administrator_login           = each.value.administrator_login
  administrator_password        = each.value.administrator_password
  zone                          = "1"

  storage_mb   = 32768
  storage_tier = "P4"

  sku_name   = each.value.sku_name
}