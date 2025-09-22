variable "image_vms" {
    description = "Number of image VMs to create"
    type        = map(string)
    default = {
        nginx-image = "Standard_D2as_v4"
        tomcat-image = "Standard_D2as_v4"
        maven-image = "Standard_D2as_v4"

      }
}