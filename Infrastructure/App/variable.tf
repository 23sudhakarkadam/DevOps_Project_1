variable "resource_group_name" {
    description = "Name of the resource group"
    type        = string
    default     = "javaapp-rg" 
}

variable "location" {
    description = "Azure region for the resource group"
    type        = string
    default     = "Central India"
}

variable "vnet" {
    description = "Vnet for Java app"
    type        = string
    default     = "vnet-javaapp"
}

variable "vnet_address_space" {
    description = "Address space for Vnet"
    type        = list(string)
    default     = ["10.0.0.0/16"]
}

variable "subnet" {
    description = "Subnets for the Vnet"
    type        = map(string)
    default = {
        web_subnet = "10.0.1.0/24"
        app_subnet = "10.0.2.0/24"
        db_subnet  = "10.0.3.0/24"
      } 
}

variable "admin_username" {
    description = "Admin username for the VMs"
    type        = string
    default     = "azureuser"
}
variable "admin_password" {
    description = "Admin password for the VMs"
    type        = string
    default     = "Azure12345678"
}

variable "vm_size" {
    description = "Size of the VMs"
    type        = string
    default     = "Standard_D2as_v4"
}


variable "nginx_image_id" {
    description = "The ID of the custom image for Nginx"
    default = "/subscriptions/28742713-55c3-4ad5-be9f-26540262491d/resourceGroups/rg-image/providers/Microsoft.Compute/images/nginx-image" 
}

variable "tomcat_image_id" {
    description = "The ID of the custom image for Tomcat"
    default = "/subscriptions/28742713-55c3-4ad5-be9f-26540262491d/resourceGroups/rg-image/providers/Microsoft.Compute/images/tomcat-image" 
}

variable "maven_image_id" {
    description = "The ID of the custom image for Maven"
    default = "/subscriptions/28742713-55c3-4ad5-be9f-26540262491d/resourceGroups/rg-image/providers/Microsoft.Compute/images/maven-image"
}

