resource "azurerm_public_ip" "web_ip" {
    name                = "web-ip"
    location            = var.location
    resource_group_name = var.resource_group_name
    allocation_method   = "Static"
    sku                 = "Standard"

    depends_on = [ azurerm_resource_group.JavaApp_rg ]
}

resource "azurerm_lb" "web_lb" {
    name                = "web-lb"
    location            = var.location
    resource_group_name = var.resource_group_name
    sku                 = "Standard"

    frontend_ip_configuration {
        name                 = "PublicIPAddress"
        public_ip_address_id = azurerm_public_ip.web_ip.id
    }
  
}

resource "azurerm_lb_backend_address_pool" "webbepool" {
    loadbalancer_id = azurerm_lb.web_lb.id
    name = "web-bepool"
}


resource "azurerm_lb_probe" "ilbprobe" {
    loadbalancer_id     = azurerm_lb.web_lb.id
    name                = "http-probe"
    protocol            = "Http"
    port                = 80
    request_path = "/"
    interval_in_seconds = 15
    number_of_probes    = 2
}

resource "azurerm_lb_rule" "fronend_rule" {
    loadbalancer_id                = azurerm_lb.web_lb.id
    name                           = "Frontend_LBRule"
    protocol                       = "Tcp"
    frontend_port                  = 80
    backend_port                   = 80
    frontend_ip_configuration_name = "PublicIPAddress"
    backend_address_pool_ids = [azurerm_lb_backend_address_pool.webbepool.id]
    probe_id = azurerm_lb_probe.ilbprobe.id
}



resource "azurerm_linux_virtual_machine_scale_set" "web_vm" {
    name = "web-vmss"
    location = var.location
    resource_group_name = var.resource_group_name
    sku = var.vm_size
    instances = 2
    admin_username = var.admin_username
    admin_password = var.admin_password
    disable_password_authentication = false
    zones = ["2", "3"]
    
    source_image_id = var.nginx_image_id
    os_disk {
      storage_account_type = "Standard_LRS"
      caching = "ReadWrite"
    }

    network_interface {
        name = "web-nic"
        primary = true
    

        ip_configuration {
        name = "internal"
        primary = true
        subnet_id = azurerm_subnet.subnet["web_subnet"].id
        load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.webbepool.id]
        }

}
}