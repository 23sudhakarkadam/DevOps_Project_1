resource "azurerm_mysql_flexible_server" "mysqldb" {
    name                   = "mysqldb"
    resource_group_name    = var.resource_group_name
    location               = var.location
    administrator_login    = "mysqladmin"
    administrator_password = "MyStrongP@ssword123!"
    sku_name               = "Standard_B1ms"
    version                = "8.0.21"

        
    backup_retention_days = 7
    geo_redundant_backup_enabled = false
    high_availability {
        mode = "ZoneRedundant" # or "SameZone" / "Disabled"
    }

    delegated_subnet_id = azurerm_subnet.subnet["db_subnet"].id
}