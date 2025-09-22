resource "azurerm_resource_group" "image_rg" {
    name     = "rg-image"
    location = "Central India"
}

resource "azurerm_virtual_network" "image_vnet" {
    name                = "vnet-image"
    address_space       = ["10.1.0.0/24"]
    location = azurerm_resource_group.image_rg.location
    resource_group_name = azurerm_resource_group.image_rg.name
}

resource "azurerm_subnet" "image_subnet" {
    name                 = "snet-image"
    resource_group_name  = azurerm_resource_group.image_rg.name
    virtual_network_name = azurerm_virtual_network.image_vnet.name
    address_prefixes     = ["10.1.0.0/24"]
}


resource "azurerm_network_interface" "image_nic" {
    for_each = var.image_vms
    name                = "$(image_vm.key)-nic"
    location            = azurerm_resource_group.image_rg.location
    resource_group_name = azurerm_resource_group.image_rg.name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.image_subnet.id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_linux_virtual_machine" "image_vm" {
    for_each = var.image_vms
    name                = each.key
    resource_group_name = azurerm_resource_group.image_rg.name
    location            = azurerm_resource_group.image_rg.location
    size                = each.value
    admin_username      = "azureuser"
    admin_password      = "Azure12345678"
    disable_password_authentication = false

    network_interface_ids = [
        azurerm_network_interface.image_nic[each.key].id,
    ]

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }
  
}