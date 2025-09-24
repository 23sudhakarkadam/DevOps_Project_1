variable "resource_group_name" {
    description = "Name of the resource group"
    type        = string
    default     = "image-rg"
  
}

variable "location" {
    description = "Azure region for the resource group"
    type        = string
    default     = "Central India"
  
}

variable "vnet_name" {
    description = "Vnet for image VMs"
    type        = string
    default     = "vnet-image"
}

variable "vnet_address_space" {
    description = "Address space for image Vnet"
    type        = list(string)
    default     = ["10.1.0.0/24"]
  
}

variable "image_vms" {
    description = "Number of image VMs to create"
    type        = map(string)
    default = {
        nginx-image = "Standard_D2as_v4"
        tomcat-image = "Standard_D2as_v4"

      }
}