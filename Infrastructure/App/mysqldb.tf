# resource "azurerm_resource_group" "mysql_rg" {
#     name = "mysql-rg"
#     location = "South India"
  
# }

# resource "azurerm_virtual_network" "mysql_vnet" {
#     name                = "mysql-vnet"
#     address_space       = ["192.168.0.0/24"]
#     location = azurerm_resource_group.mysql_rg.location
#     resource_group_name = azurerm_resource_group.mysql_rg.name
# }

# resource "azurerm_subnet" "mysql_subnet" {
#   name                 = "mysql-subnet"
#   resource_group_name  = azurerm_resource_group.mysql_rg.name
#   virtual_network_name = azurerm_virtual_network.mysql_vnet.name
#   address_prefixes     = ["192.168.0.0/24"]

#   delegation {
#     name = "mysqlfsdelegation"
#     service_delegation {
#       name = "Microsoft.DBforMySQL/flexibleServers"
#       actions = [
#         "Microsoft.Network/virtualNetworks/subnets/join/action",
#       ]
#     }
#   }
# }

# resource "azurerm_mysql_flexible_server" "mysqldbskenvironmentci" {
#     name                   = "mysqldbskenvironmentci"
#     resource_group_name    = azurerm_resource_group.mysql_rg.name
#     location               = azurerm_resource_group.mysql_rg.location
#     version = "8.0.21"
#     administrator_login    = "mysqladmin"
#     administrator_password = "MyStrongP@ssword123!"
#     sku_name               = "B_Standard_B2ms"
    
        
#     backup_retention_days = 7
#     geo_redundant_backup_enabled = false
   

#     delegated_subnet_id = azurerm_subnet.mysql_subnet.id
# }

# resource "azurerm_mysql_flexible_database" "Userdb" {
#   name                = "Userdb"
#   resource_group_name = azurerm_resource_group.mysql_rg.name
#   server_name         = azurerm_mysql_flexible_server.mysqldbskenvironmentci.name
#   charset             = "utf8"
#   collation           = "utf8_unicode_ci"
# }