terraform {
required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  skip_provider_registration = true
  features {}
}

variable "prefix" {
  default = "dotnetcoresample"
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  resource_group_name = "ranjith"
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = "ranjith"
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "vm_public_ip"
  resource_group_name = "ranjith"
  location            = "eastus"
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = "eastus"
  resource_group_name = "ranjith"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
	public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}
resource "azurerm_network_security_group" "main" {
  name                = "dotnetcore_nsg"
  location            = "eastus"
  resource_group_name = "ranjith"

  security_rule {
    name                       = "allow_ssh_sg"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "association" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_windows_virtual_machine" "main" {
  name                  = "${var.prefix}-dotnetcore-vm"
  location              = "eastus"
  resource_group_name   = "ranjith"
  network_interface_ids = [azurerm_network_interface.main.id]
  size                  = "Standard_DS1_v2"
  admin_username        = "dotnet"
  admin_password        = "Dotnet@12345"
  computer_name         = "dotnetcore"
	
   os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  plan {
   name = "belvmsrviis01"
   publisher = "belindaczsro1588885355210"
   product = "belvmsrviis"
  }

  source_image_reference {
    publisher = "belindaczsro1588885355210"
    offer     = "belvmsrviis"
    sku       = "belvmsrviis01"
    version   = "latest"
  }
}
