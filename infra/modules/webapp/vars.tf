variable "rgname" {
  default     = "dotnetIIS"
}

variable "aspname" {
  default     = "dotnetiisasp"
}


variable "environment" {
  default     = "dev"
}

variable "location" {
  default     = "eastus"
}

variable "dns_prefix" {
  default     = "hexa-dotnet-poc"
}

variable "plan_tier" {
  default     = "Standard"
}

variable "plan_sku" {
  default     = "S1"
}