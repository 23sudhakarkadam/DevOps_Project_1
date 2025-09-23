resource "azurerm_network_interface" "maven-nic" {
  name                = "maven-nic"
  location            = var.location
  resource_group_name = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet["app_subnet"].id
    private_ip_address_allocation = "dynamic"
  }
}





resource "azurerm_linux_virtual_machine" "maven-vm" {
  name                = "maven-vm"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_D2as_v4"
  admin_username      = var.admin_username
  admin_password = var.admin_password
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.maven-nic.id,
  ]


  source_image_id = "/subscriptions/28742713-55c3-4ad5-be9f-26540262491d/resourceGroups/rg-image/providers/Microsoft.Compute/images/maven-image"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}