resource "azurerm_resource_group" "rg-env" {
    name     = var.resource_group_name
    location = var.location
}

resource "azurerm_virtual_network" "vnet-env" {
    name                = var.vnet
    address_space       = var.vnet_address_space
    location = azurerm_resource_group.rg-env.location
    resource_group_name = azurerm_resource_group.rg-env.name
}

resource "azurerm_subnet" "subnet" {
    for_each = var.subnet
    name                 = each.key
    resource_group_name  = var.resource_group_name
    virtual_network_name = var.vnet
    address_prefixes     = [each.value]
}

resource "azurerm_network_security_group" "web_nsg" {
    name                = "web_nsg"
    location            = var.location
    resource_group_name = var.resource_group_name

    security_rule {
        name                       = "Web"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    depends_on = [ azurerm_resource_group.rg-env ]
  
}

resource "azurerm_subnet_network_security_group_association" "web_nsg_ass" {
    subnet_id = azurerm_subnet.subnet["web_subnet"].id
    network_security_group_id = azurerm_network_security_group.web_nsg.id
}



