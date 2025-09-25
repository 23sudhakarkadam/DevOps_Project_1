resource "azurerm_resource_group" "mysql_rg" {
    name = var.resource_group_name
    location = var.location
  
}



resource "azurerm_subnet" "db_subnet" {
  name                 = "db_subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet
  address_prefixes     = ["10.0.3.0/24"]

  delegation {
    name = "mysqlfsdelegation"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_mysql_flexible_server" "mysqldbskenvironmentci" {
    name                   = "mysqldbskenvironmentci"
    resource_group_name    = azurerm_resource_group.mysql_rg.name
    location               = azurerm_resource_group.mysql_rg.location
    version = "8.0.21"
    administrator_login    = "mysqladmin"
    administrator_password = "MyStrongP@ssword123!"
    sku_name               = "B_Standard_B2ms"
    
        
    backup_retention_days = 7
    geo_redundant_backup_enabled = false
    public_network_access = "Enabled"
   
}

resource "azurerm_mysql_flexible_database" "Userdb" {
  name                = "Userdb"
  resource_group_name = azurerm_resource_group.mysql_rg.name
  server_name         = azurerm_mysql_flexible_server.mysqldbskenvironmentci.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}