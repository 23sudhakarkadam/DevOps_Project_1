resource "azurerm_mysql_flexible_server" "mysqldbskenvironmentci" {
    name                   = "mysqldbskenvironmentci"
    resource_group_name    = var.resource_group_name
    location               = var.location
    administrator_login    = "mysqladmin"
    administrator_password = "MyStrongP@ssword123!"
    sku_name               = "B_Standard_B2ms"
    
        
    backup_retention_days = 7
    geo_redundant_backup_enabled = false
    high_availability {
        mode = "ZoneRedundant" # or "SameZone" / "Disabled"
    }

    delegated_subnet_id = azurerm_subnet.subnet["db_subnet"].id
}

resource "azurerm_mysql_flexible_database" "Userdb" {
  name                = "Userdb"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.mysqldb.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}