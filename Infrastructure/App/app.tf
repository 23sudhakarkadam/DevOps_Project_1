
# resource "azurerm_lb" "app_lb" {
#     name                = "app-lb"
#     location            = var.location
#     resource_group_name = var.resource_group_name
#     sku                 = "Standard"

#     frontend_ip_configuration {
#         name                 = "PrivateIPAddress"
#         subnet_id = azurerm_subnet.subnet["app_subnet"].id
#         private_ip_address_allocation = "Static"
#         private_ip_address = "10.0.2.5"
#     }
  
# }

# resource "azurerm_lb_backend_address_pool" "appbepool" {
#     loadbalancer_id = azurerm_lb.app_lb.id
#     name = "app-bepool"
# }


# resource "azurerm_lb_probe" "appilbprobe" {
#     loadbalancer_id     = azurerm_lb.app_lb.id
#     name                = "tcp-probe"
#     protocol            = "Tcp"
#     port                = 8080

# }

# resource "azurerm_lb_rule" "backend_rule" {
#     loadbalancer_id                = azurerm_lb.app_lb.id
#     name                           = "Backend_LBRule"
#     protocol                       = "Tcp"
#     frontend_port                  = 8080
#     backend_port                   = 8080
#     frontend_ip_configuration_name = "PrivateIPAddress"
#     backend_address_pool_ids = [azurerm_lb_backend_address_pool.appbepool.id]
#     probe_id = azurerm_lb_probe.appilbprobe.id
# }



# resource "azurerm_linux_virtual_machine_scale_set" "app_vm" {
#     name = "app-vmss"
#     location = var.location
#     resource_group_name = var.resource_group_name
#     sku = var.vm_size
#     instances = 2
#     admin_username = var.admin_username
#     admin_password = var.admin_password
#     disable_password_authentication = false
#     zones = ["2", "3"]
    
#     source_image_id = var.tomcat_image_id
#     os_disk {
#       storage_account_type = "Standard_LRS"
#       caching = "ReadWrite"
#     }

#     network_interface {
#         name = "app-nic"
#         primary = true
    

#         ip_configuration {
#         name = "internal"
#         primary = true
#         subnet_id = azurerm_subnet.subnet["app_subnet"].id
#         load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.appbepool.id]
#         }

# }
# }