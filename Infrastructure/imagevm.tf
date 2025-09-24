# resource "azurerm_public_ip" "images_IP" {
#     for_each = var.image_vms
#     name = "${each.key}-ip"
#     location = azurerm_resource_group.image_rg.location
#     resource_group_name = azurerm_resource_group.image_rg.name
#     allocation_method = "Static"  
# }


# resource "azurerm_network_interface" "image_nic" {
#     for_each = var.image_vms
#     name                = "${each.key}-nic"
#     location            = azurerm_resource_group.image_rg.location
#     resource_group_name = azurerm_resource_group.image_rg.name

#     ip_configuration {
#         name                          = "internal"
#         subnet_id                     = azurerm_subnet.image_subnet.id
#         private_ip_address_allocation = "Dynamic"
#         public_ip_address_id = azurerm_public_ip.images_IP[each.key].id
#     }
# }

# resource "azurerm_linux_virtual_machine" "image_vm" {
#     for_each = var.image_vms
#     name                = each.key
#     resource_group_name = azurerm_resource_group.image_rg.name
#     location            = azurerm_resource_group.image_rg.location
#     size                = each.value
#     admin_username      = "azureuser"
#     admin_password      = "Azure12345678"
#     disable_password_authentication = false

#     network_interface_ids = [
#         azurerm_network_interface.image_nic[each.key].id,
#     ]

#     os_disk {
#         caching              = "ReadWrite"
#         storage_account_type = "Standard_LRS"
#     }

#     source_image_reference {
#         publisher = "Canonical"
#         offer     = "UbuntuServer"
#         sku       = "18.04-LTS"
#         version   = "latest"
#     }
  
# }


# resource "azurerm_network_security_group" "image_nsg" {
#     name                = "image_nsg"
#     location            = azurerm_resource_group.image_rg.location  
#     resource_group_name = azurerm_resource_group.image_rg.name

#     security_rule {
#         name                       = "SSH"
#         priority                   = 1001
#         direction                  = "Inbound"
#         access                     = "Allow"
#         protocol                   = "Tcp"
#         source_port_range          = "*"
#         destination_port_range     = "22"
#         source_address_prefix      = "*"
#         destination_address_prefix = "*"
#     }
  
# }

# resource "azurerm_subnet_network_security_group_association" "nsg_ass" {
#     subnet_id = azurerm_subnet.image_subnet.id
#     network_security_group_id = azurerm_network_security_group.image_nsg.id
  
# }



