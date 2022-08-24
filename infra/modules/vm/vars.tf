variable "rg_name" {
  default     = "ranjith"
}
variable "location" {
  default     = "eastus"
}
variable "vnet_name" {
  default     = "dotnetcoresamplevnet"
}
variable "vnet_cidr" {
  default     = ["10.0.0.0/16"]
}
variable "subnet_name" {
  default     = "dotnetcoresamplesubnet"
}
variable "subnet_cidr" {
  default     = ["10.0.2.0/24"]
}
variable "network_interface_name" {
  default     = "dotnetcoresamplenic"
}
variable "nsg_name" {
  default     = "dotnetcoresamplensg"
}
variable "publicip_name" {
  default     = "dotnetcoresamplepubip"
}
variable "vm_name" {
  default     = "dotnetcoresamplevm"
}
variable "vm_username" {
  default     = "dotnet"
}
variable "vm_password" {
  default     = "Dotnet@12345"
}
