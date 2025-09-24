# resource "azurerm_subnet" "bastion_subnet" {
#   name                 = "AzureBastionSubnet"
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = ["10.0.5.0/27"]
# }

# resource "azurerm_public_ip" "bastion_pip" {
#   name                = "bastion-pip"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

# resource "azurerm_bastion_host" "bastion" {
#   name                = "bastion-host"
#   location            = var.location
#   resource_group_name = var.resource_group_name
# #   dns_name            = "bastion-${azurerm_resource_group.JavaApp_rg.name}"
  
#   ip_configuration {
#     name                 = "bastion-ip-config"
#     subnet_id            = azurerm_subnet.bastion_subnet.id
#     public_ip_address_id = azurerm_public_ip.bastion_pip.id
#   }
# }