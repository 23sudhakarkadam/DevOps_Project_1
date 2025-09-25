resource "azurerm_image" "example" {
    for_each = var.image_vms
    name                      = "${each.key}-image"
    location                  = var.location
    resource_group_name       = var.location
    source_virtual_machine_id = azurerm_linux_virtual_machine.image_vm[each.key].id
}