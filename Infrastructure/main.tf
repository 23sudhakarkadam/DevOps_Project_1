# resource "azurerm_resource_group" "image_rg" {
#     name     = var.resource_group_name
#     location = var.location
# }

# resource "azurerm_virtual_network" "image_vnet" {
#     name                = var.vnet_name
#     address_space       = var.vnet_address_space
#     location = azurerm_resource_group.image_rg.location
#     resource_group_name = azurerm_resource_group.image_rg.name
# }

# resource "azurerm_subnet" "image_subnet" {
#     name                 = "snet-image"
#     resource_group_name  = azurerm_resource_group.image_rg.name
#     virtual_network_name = azurerm_virtual_network.image_vnet.name
#     address_prefixes     = ["10.1.0.0/24"]
# }